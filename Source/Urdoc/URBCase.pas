unit URBCase;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, DBCtrls, Grids, DBGrids, Buttons,
  UEditCase, UNewDbGrids, inifiles, IBCustomDataSet, IBQuery, IBTable,
  ImgList, Db,IBDatabase;

type
  TfmCase = class(TForm)
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
    FindNomin: string;
    FindGenit: string;
    FindDativ: string;
    FindCreat: string;
    FindVinit: string;
    FindPredl: string;
    isFindNomin,isFindGenit,isFindDativ,isFindCreat,isFindVinit,isFindPredl: Boolean;
    FilterInSide: Boolean;
    procedure GridDrawColumnCell(Sender: TObject; const Rect: TRect;
                                 DataCol: Integer; Column: TColumn;
                                 State: TGridDrawState);
    procedure GridTitleClick(Column: TColumn);
    procedure GridDblClick(Sender: TObject);
    procedure SetImageFilter;
    procedure SaveFilter;
    procedure ViewCount;
    function GetFilterString: string;
    function CaseNominExists(strName: String; var ID: Integer): Boolean;

  public
    Grid: TNewdbGrid;
    procedure MR(Sender: TObject);
    procedure ActiveQuery;
    procedure LoadFilter;
  end;

var
  fmCase: TfmCase;
   
implementation

uses Udm, UMain;

{$R *.DFM}

procedure TfmCase.FormCreate(Sender: TObject);
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
  Grid.OnDrawColumnCell:=GridDrawColumnCell;
  Grid.OnDblClick:=GridDblClick;
  Grid.OnKeyDown:=FormKeyDown;

  OnKeyDown:=fmMain.OnKeyDown;
  OnKeyPress:=fmMain.OnKeyPress;
  OnKeyUp:=fmMain.OnKeyUp;
  Mainqr.Database:=dm.IBDbase;
end;

procedure TfmCase.ActiveQuery;
var
 sqls: String;
 cl: TColumn;
begin
  ds.DataSet:=nil;
  Mainqr.Active:=false;
  Mainqr.sql.Clear;
  sqls:='Select * from '+TableCase+GetFilterString+' order by nomin';
  Mainqr.sql.Add(sqls);
  Mainqr.Active:=true;
  ds.DataSet:=Mainqr;
  SetImageFilter;
  ViewCount;
  if Grid.Columns.Count<>4 then begin
   cl:=Grid.Columns.Add;
   cl.FieldName:='nomin';
   cl.Title.Caption:='������������';
   cl.Width:=100;

   cl:=Grid.Columns.Add;
   cl.FieldName:='genit';
   cl.Title.Caption:='�����������';
   cl.Width:=100;

   cl:=Grid.Columns.Add;
   cl.FieldName:='dativ';
   cl.Title.Caption:='���������';
   cl.Width:=100;

   cl:=Grid.Columns.Add;
   cl.FieldName:='creat';
   cl.Title.Caption:='������������';
   cl.Width:=100;

   cl:=Grid.Columns.Add;
   cl.FieldName:='vinit';
   cl.Title.Caption:='�����������';
   cl.Width:=100;

   cl:=Grid.Columns.Add;
   cl.FieldName:='predl';
   cl.Title.Caption:='����������';
   cl.Width:=100;

  end;
end;

procedure TfmCase.bibAddClick(Sender: TObject);
var
  fm: TfmEditCase;
  qr: TIBQuery;
  RetVal: Boolean;
  valname: string;
  sqls: string;
  id: Integer;
  tr: TIBTransaction;
begin
 fm:=TfmEditCase.Create(nil);
 try
  fm.Caption:=captionAdd;
  fm.bibOk.OnClick:=fm.AddAndChangeOkClick;
  if fm.ShowModal=mrOk then begin

    valname:=Trim(fm.edNomin.Text);
    retval:=CaseNominExists(valname,id);
    if retVal then begin
      ShowError(Application.handle,'�������� <'+valname+'> '+#13+
               '� ���� <'+fm.lbnomin.Caption+'>'+#13+
               valuePresent);
      MainQr.Locate('case_id',id,[loCaseInsensitive]);
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
     sqls:='Insert into '+TableCase+' (nomin,genit,dativ,creat,vinit,predl) '+
           ' values ('''+valname+
           ''','''+Trim(fm.edGenit.Text)+
           ''','''+Trim(fm.eddativ.Text)+
           ''','''+Trim(fm.edCreat.Text)+
           ''','''+Trim(fm.edVinit.Text)+
           ''','''+Trim(fm.edPredl.Text)+''')';
     qr.SQL.Add(sqls);
     qr.ExecSQL;
     qr.Transaction.CommitRetaining;
    finally
     qr.Free;
     tr.Free;
     Mainqr.Active:=false;
     Mainqr.Active:=true;
     Mainqr.Locate('nomin',valname,[loPartialKey,loCaseInsensitive]);
     ViewCount;
     Screen.Cursor:=crDefault;
    end;
  end;
 finally
  fm.Free;
 end;
end;

procedure TfmCase.bibChangeClick(Sender: TObject);
var
  fm: TfmEditCase;
  qr: TIBQuery;
  RetVal: Boolean;
  valname: string;
  id: Integer;
  sqls: string;
  tr: TIBTransaction;
begin
 if MainQr.RecordCount=0 then exit;
 fm:=TfmEditCase.Create(nil);
 try
  fm.Caption:=captionChange;
  fm.edNomin.text:=Trim(MainQr.FieldByName('nomin').AsString);
  fm.edGenit.Text:=Trim(MainQr.FieldByName('genit').AsString);
  fm.edDativ.Text:=Trim(MainQr.FieldByName('dativ').AsString);
  fm.edCreat.Text:=Trim(MainQr.FieldByName('creat').AsString);
  fm.edVinit.Text:=Trim(MainQr.FieldByName('vinit').AsString);
  fm.edPredl.Text:=Trim(MainQr.FieldByName('predl').AsString);

  fm.bibOk.OnClick:=fm.AddAndChangeOkClick;
  fm.ChangeFlag:=false;

  if fm.ShowModal=mrOk then begin

    if not fm.ChangeFlag then exit;
    valname:=Trim(fm.edNomin.Text);
    retval:=CaseNominExists(valname,Id);
    if (retVal)and(MainQr.FieldByName('case_id').AsInteger<>id) then begin
      ShowError(Application.handle,'�������� <'+valname+'> '+#13+
               '� ���� <'+fm.lbnomin.Caption+'>'+#13+
               valuePresent);
      MainQr.Locate('case_id',id,[loPartialKey,loCaseInsensitive]);
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
     sqls:='Update '+TableCase+
           ' set nomin='''+valname+''', genit='''+Trim(fm.edGenit.Text)+
           ''', dativ='''+Trim(fm.edDativ.Text)+
           ''', creat='''+Trim(fm.edCreat.Text)+
           ''', vinit='''+Trim(fm.edVinit.Text)+
           ''', predl='''+Trim(fm.edPredl.Text)+
           ''' where case_id='+inttostr(MainQr.FieldByName('case_id').AsInteger);
     qr.SQL.Add(sqls);
     qr.ExecSQL;
     qr.Transaction.CommitRetaining;
    finally
     qr.Free;
     tr.Free;
     Mainqr.Active:=false;
     Mainqr.Active:=true;
     Mainqr.Locate('nomin',valname,[loPartialKey,loCaseInsensitive]);
     ViewCount;
     Screen.Cursor:=crDefault;
    end;
  end;
 finally
  fm.Free;
 end;
end;

procedure TfmCase.bibDelClick(Sender: TObject);

  function DeleteRecord: Boolean;
  var
    qr: TIBQuery;
    sqls: string;
    tr: TIBTransaction;
  begin
   Result:=false; 
   Screen.Cursor:=crHourGlass;
   tr:=TIBTransaction.Create(nil);
   qr:=TIBQuery.Create(nil);
   try
    try
     Result:=false;
     tr.AddDatabase(dm.IBDbase);
     dm.IBDbase.AddTransaction(tr);
     tr.Params.Text:=DefaultTransactionParamsTwo;
     qr.Database:=dm.IBDbase;
     qr.Transaction:=tr;
     qr.Transaction.Active:=true;
     sqls:='Delete from '+Tablecase+' where case_id='+
          Mainqr.FieldByName('case_id').asString;
     qr.sql.Add(sqls);
     qr.ExecSQL;
     qr.Transaction.CommitRetaining;
     Result:=true;
     Mainqr.Active:=false;
     Mainqr.Active:=true;
     Mainqr.Last;
     ViewCount;
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
//  but:=MessageBox(Handle,Pchar('������� ?'),'��������������',MB_YESNO+MB_ICONWARNING);
  if mr=mrYes then begin
    if not deleteRecord then begin
      ShowError(Application.Handle,'����� <'+Mainqr.FieldByName('nomin').AsString+'> ������������.');
    end;
  end;
end;

procedure TfmCase.bibFilterClick(Sender: TObject);
var
  fm: TfmEditCase;
  filstr: string;
begin
 fm:=TfmEditCase.Create(nil);
 try
  fm.Caption:=CaptionFilter;
  fm.bibOk.OnClick:=fm.FilterOk;

  if Trim(FindNomin)<>'' then fm.edNomin.Text:=FindNomin;
  if Trim(FindGenit)<>'' then fm.edGenit.Text:=FindGenit;
  if Trim(FindDativ)<>'' then fm.edDativ.Text:=FindDativ;
  if Trim(FindCreat)<>'' then fm.edCreat.Text:=FindCreat;
  if Trim(FindVinit)<>'' then fm.edVinit.Text:=FindVinit;
  if Trim(FindPredl)<>'' then fm.edPredl.Text:=FindPredl;

  fm.cbInString.Visible:=true;
  fm.cbInString.Checked:=FilterInSide;
  fm.ChangeFlag:=false;

  if fm.ShowModal=mrOk then begin

    FindNomin:=Trim(fm.edNomin.Text);
    isFindNomin:=Trim(FindNomin)<>'';
    FindGenit:=Trim(fm.edGenit.Text);
    isFindGenit:=Trim(FindGenit)<>'';
    Finddativ:=Trim(fm.edDativ.Text);
    isFinddativ:=Trim(FindDativ)<>'';
    FindCreat:=Trim(fm.edCreat.Text);
    isFindCreat:=Trim(FindCreat)<>'';
    FindVinit:=Trim(fm.edVinit.Text);
    isFindVinit:=Trim(FindVinit)<>'';
    FindPredl:=Trim(fm.edPredl.Text);
    isFindPredl:=Trim(FindPredl)<>'';

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

procedure TfmCase.bibPrintClick(Sender: TObject);
begin
  CreateWordTableByGrid(Grid,Caption);
end;

procedure TfmCase.MR(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

procedure TfmCase.edSearchKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if not isValidKey(Char(Key)) then exit;
  if MainQr.IsEmpty then exit;
  if grid.SelectedField=nil then exit;
  MainQr.Locate(grid.SelectedField.FullName,Trim(edSearch.Text),
                [loPartialKey,loCaseInsensitive]);
end;

procedure TfmCase.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TfmCase.bibCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfmCase.GridTitleClick(Column: TColumn);
var
  fn: string;
  id: integer;
begin
  if not MainQr.Active then exit;
  if MainQr.RecordCount=0 then exit;
  Screen.Cursor:=crHourGlass;
  try
   fn:=Column.FieldName;
   id:=MainQr.fieldByName('case_id').asInteger;
   MainQr.Active:=false;
   MainQr.SQL.Clear;
   MainQr.SQL.Add('Select * from '+TableCase+GetFilterString+' Order by '+fn);
   MainQr.Active:=true;
   MainQr.First;
   MainQr.Locate('case_id',id,[loCaseInsensitive]);
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TfmCase.FormDestroy(Sender: TObject);
begin
  Grid.Free;
  if fsCreatedMDIChild in FormState then
   fmCase:=nil;
end;

procedure TfmCase.SetImageFilter;
begin
  bibFilter.Glyph.Assign(nil);
  bibFilter.Glyph.Width:=dm.IlMain.Width;
  bibFilter.Glyph.Height:=dm.IlMain.Height;
  if isFindNomin or isFindGenit or
     isFinddativ or isFindCreat or
     isFindVinit or isFindPredl
     then begin
    dm.IlMain.draw(bibFilter.Glyph.Canvas,0,0,0,true);
  end else begin
    dm.IlMain.draw(bibFilter.Glyph.Canvas,0,0,1,true);
  end;
end;

procedure TfmCase.LoadFilter;
var
  fi: TIniFile;
begin
  fi:=TIniFile.Create(GetIniFileName);
  try
    FindNomin:=fi.ReadString('RBCase','Nomin',FindNomin);
    FindGenit:=fi.ReadString('RBCase','Genit',FindGenit);
    FindDativ:=fi.ReadString('RBCase','Dativ',FindDativ);
    FindCreat:=fi.ReadString('RBCase','Creat',FindCreat);
    FindVinit:=fi.ReadString('RBCase','Vinit',FindVinit);
    FindPredl:=fi.ReadString('RBCase','Predl',FindPredl);
    FilterInside:=fi.ReadBool('RBCase','Inside',FilterInside);
  finally
   fi.Free;
  end;
end;

procedure TfmCase.SaveFilter;
var
  fi: TIniFile;
begin
  fi:=TIniFile.Create(GetIniFileName);
  try
    fi.WriteString('RBCase','Nomin',FindNomin);
    fi.WriteString('RBCase','Genit',FindGenit);
    fi.WriteString('RBCase','Dativ',FindDativ);
    fi.WriteString('RBCase','Creat',FindCreat);
    fi.WriteString('RBCase','Vinit',FindVinit);
    fi.WriteString('RBCase','Predl',FindPredl);

    fi.WriteBool('RBCase','Inside',FilterInside);
  finally
   fi.Free;
  end;
end;

function TfmCase.GetFilterString: string;
var
  FilInSide: string;
  wherestr: string;
  addstr1,addstr2,addstr3,addstr4,addstr5,addstr6: string;
  and1,and2,and3,and4,and5: string;
begin
    Result:='';

    isFindNomin:=Trim(FindNomin)<>'';
    isFindGenit:=Trim(FindGenit)<>'';
    isFindDativ:=Trim(FindDativ)<>'';
    isFindCreat:=Trim(FindCreat)<>'';
    isFindVinit:=Trim(FindVinit)<>'';
    isFindPredl:=Trim(FindPredl)<>'';


    if isFindNomin or isFindGenit or
       isFindDativ or isFindCreat or
       isFindVinit or isFindPredl then begin
     wherestr:=' where ';
    end else begin
    end;

    if FilterInside then FilInSide:='%';

     if isFindNomin then begin
        addstr1:=' Upper(nomin) like '+AnsiUpperCase(QuotedStr(FilInSide+FindNomin+'%'))+' ';
     end;

     if isFindGenit then begin
        addstr2:=' Upper(genit) like '+AnsiUpperCase(QuotedStr(FilInSide+FindGenit+'%'))+' ';
     end;

     if isFindDativ then begin
        addstr3:=' Upper(dativ) like '+AnsiUpperCase(QuotedStr(FilInSide+FindDativ+'%'))+' ';
     end;

     if isFindCreat then begin
        addstr4:=' Upper(creat) like '+AnsiUpperCase(QuotedStr(FilInSide+FindCreat+'%'))+' ';
     end;

     if isFindVinit then begin
        addstr5:=' Upper(vinit) like '+AnsiUpperCase(QuotedStr(FilInSide+FindVinit+'%'))+' ';
     end;

     if isFindPredl then begin
        addstr6:=' Upper(predl) like '+AnsiUpperCase(QuotedStr(FilInSide+FindPredl+'%'))+' ';
     end;

     if (isFindNomin and isFindGenit)or
        (isFindNomin and isFindDativ)or
        (isFindNomin and isFindCreat)or
        (isFindNomin and isFindVinit)or
        (isFindNomin and isFindPredl)
        then  and1:=' and ';

     if (isFindGenit and isFindDativ)or
        (isFindGenit and isFindCreat)or
        (isFindGenit and isFindVinit)or
        (isFindGenit and isFindPredl)
        then and2:=' and ';

     if (isFindDativ and isFindCreat)or
        (isFindDativ and isFindVinit)or
        (isFindDativ and isFindPredl)
        then  and3:=' and ';

     if (isFindCreat and isFindVinit)or
        (isFindCreat and isFindPredl)
        then  and4:=' and ';

     if (isFindVinit and isFindPredl)
        then  and5:=' and ';

     Result:=wherestr+addstr1+and1+addstr2+and2+
                      addstr3+and3+addstr4+and4+
                      addstr5+and4+addstr6;

end;

procedure TfmCase.ViewCount;
begin
 if MainQr.Active then
  lbCount.Caption:=ViewCountText+inttostr(GetRecordCount(Mainqr));
end;

procedure TfmCase.MainqrAfterOpen(DataSet: TDataSet);
begin
  ViewCount;
end;

procedure TfmCase.GridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
end;

procedure TfmCase.GridDblClick(Sender: TObject);
begin
  if not Mainqr.Active then exit;
  if Mainqr.RecordCount=0 then exit;
  bibChangeClick(nil);
end;

function TfmCase.CaseNominExists(strName: String; var ID: Integer): Boolean;
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
   sqls:='Select * from '+TableCase+' where nomin='''+Trim(strName)+'''';
   qr.SQL.Add(sqls);
   qr.Active:=true;
   if qr.recordCount=1 then begin
     ID:=qr.FieldByName('case_id').ASInteger;
     Result:=true;
   end;
  finally
   qr.Free;
   tr.Free;
   Screen.Cursor:=CrDefault;
  end;
end;

procedure TfmCase.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfmCase.FormResize(Sender: TObject);
begin
  edSearch.Width:=Self.Width-edSearch.Left-pnBut.Width-8;
end;

end.