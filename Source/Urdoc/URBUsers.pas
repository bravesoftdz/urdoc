unit URBUsers;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, DBCtrls, Grids, DBGrids, Buttons,
  UEditUsers, UNewDbGrids, inifiles, IBCustomDataSet, IBQuery, IBTable,
  ImgList, Db,IBDatabase;

type
  TfmUsers = class(TForm)
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
    FindName: string;
    isFindName: Boolean;
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
    function UserNameExists(strName: String; var ID: Integer): Boolean;
  public
    Grid: TNewdbGrid;
    procedure MR(Sender: TObject);
    procedure ActiveQuery;
    procedure LoadFilter;
  end;

var
  fmUsers: TfmUsers;
   
implementation

uses Udm, UMain;

{$R *.DFM}

procedure TfmUsers.FormCreate(Sender: TObject);
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

procedure TfmUsers.ActiveQuery;
var
 sqls: String;
 cl: TColumn;
begin
  ds.DataSet:=nil;
  Mainqr.Active:=false;
  Mainqr.sql.Clear;
  sqls:='SELECT * FROM '+TableUsers+GetFilterString+' order by name ';
  Mainqr.sql.Add(sqls);
  Mainqr.Active:=true;
  ds.DataSet:=Mainqr;
  SetImageFilter;
  ViewCount;
  if Grid.Columns.Count<>2 then begin
   cl:=Grid.Columns.Add;
   cl.FieldName:='Name';
   cl.Title.Caption:='��� ������������';
   cl.Width:=200;

   cl:=Grid.Columns.Add;
//   cl.FieldName:='flagadmin';
   cl.Title.Caption:='�������������';
   cl.Width:=85;

  end;
end;

procedure TfmUsers.bibAddClick(Sender: TObject);
var
  fm: TfmEditUsers;
  RetVal: Boolean;
  valname: string;
  pass: string;
  ms: TMemoryStream;
  ID: Integer;
  tr: TIBTransaction;
  tb: TIBTable;
begin
 fm:=TfmEditUsers.Create(nil);
 try
  fm.Caption:=captionAdd;
  fm.btOk.OnClick:=fm.OkClick;
  if fm.ShowModal=mrOk then begin

    valname:=Trim(fm.edName.Text);
    retval:=UserNameExists(valname,ID);
    if retVal then begin
      ShowError(Application.handle,'�������� <'+valname+'> '+#13+
               '� ���� <'+fm.lbname.Caption+'>'+#13+
               valuePresent);
      MainQr.Locate('user_id',id,[loCaseInsensitive]);         
      exit;
    end;
    Screen.Cursor:=crHourGlass;
    tr:=TIBTransaction.Create(nil);
    tb:=TIBTable.Create(nil);
    ms:=TMemoryStream.Create;
    try
      tr.AddDatabase(dm.IBDbase);
     dm.IBDbase.AddTransaction(tr);
     tr.Params.Text:=DefaultTransactionParamsTwo;
     tb.Database:=dm.IBDbase;
     tb.Transaction:=tr;
     tb.Transaction.Active:=true;
     tb.TableName:=TableUsers;
     tb.Filter:=' user_id=0 ';
     tb.Filtered:=true;
     tb.Active:=true;
     tb.Append;
     tb.FieldByName('name').AsString:=valname;
     if fm.chbAdmin.Checked then
      tb.FieldByName('flagadmin').AsInteger:=1
     else tb.FieldByName('flagadmin').AsInteger:=0;
     tb.FieldByName('progadmin').AsInteger:=tb.FieldByName('flagadmin').AsInteger;

     pass:=trim(fm.EdPass.text);
     ms.Write(Pointer(pass)^,Length(pass));
     ms.Position:=0;
     TranslateStream(ms,true);
     ms.Position:=0;
     TBlobField(tb.FieldByName('userpass')).LoadFromStream(ms);

     tb.FieldByName('user_id').Required:=false;


     tb.Post;
     tb.Transaction.CommitRetaining;
    finally
     ms.Free;
     tb.Free;
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

procedure TfmUsers.bibChangeClick(Sender: TObject);
var
  fm: TfmEditUsers;
  tb: TIBTable;
  RetVal: Boolean;
  valname: string;
  pass: string;
  ms: TMemoryStream;
  Id: Integer;
  tr: TIBTransaction;
begin
 if MainQr.RecordCount=0 then exit;
 fm:=TfmEditUsers.Create(nil);
 ms:=TMemoryStream.Create;
 try
  fm.Caption:=captionChange;
  fm.edName.text:=Trim(MainQr.FieldByName('name').AsString);
  fm.chbAdmin.Checked:=MainQr.FieldByName('flagadmin').AsString='1';

  TBlobField(MainQr.FieldByName('userpass')).SaveToStream(ms);
  ms.Position:=0;
  fm.edPass.text:=TranslateStream(ms,false);
  fm.btOk.OnClick:=fm.OkClick;
  fm.ChangeFlag:=false;

  if fm.ShowModal=mrOk then begin

    if not fm.ChangeFlag then exit;
    valname:=Trim(fm.edName.Text);
    retval:=UserNameExists(valname,Id);
    if (retVal)and(MainQr.FieldByName('user_id').AsInteger<>id) then begin
      ShowError(Application.handle,'�������� <'+valname+'> '+#13+
               '� ���� <'+fm.lbname.Caption+'>'+#13+
               valuePresent);
      MainQr.Locate('user_id',id,[loCaseInsensitive]);
      exit;
    end;
    Screen.Cursor:=crHourGlass;
    tr:=TIBTransaction.Create(nil);
    tb:=TIBTable.Create(nil);
    try
     tr.AddDatabase(dm.IBDbase);
     dm.IBDbase.AddTransaction(tr);
     tr.Params.Text:=DefaultTransactionParamsTwo;
     tb.Database:=dm.IBDbase;
     tb.Transaction:=tr;
     tb.Transaction.Active:=true;
     tb.TableName:=TableUsers;
     tb.Filter:=' user_id='+Mainqr.FieldByname('user_id').AsString;
     tb.Filtered:=true;
     tb.Active:=true;
     tb.Locate('user_id',MainQr.FieldByName('user_id').AsInteger,[loCaseInsensitive]);
     tb.Edit;
     tb.FieldByName('name').AsString:=valname;
     if fm.chbAdmin.Checked then
      tb.FieldByName('flagadmin').AsInteger:=1
     else tb.FieldByName('flagadmin').AsInteger:=0;
     tb.FieldByName('progadmin').AsInteger:=Mainqr.FieldByname('flagadmin').AsInteger;

     pass:=trim(fm.EdPass.text);
     ms.Clear;
     ms.Write(Pointer(pass)^,Length(pass));
     ms.Position:=0;
     TranslateStream(ms,true);
     ms.Position:=0;
     TBlobField(tb.FieldByName('userpass')).LoadFromStream(ms);
     tb.Post;
     tb.Transaction.CommitRetaining;
    finally
     ms.Free;
     tb.Free;
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

procedure TfmUsers.bibDelClick(Sender: TObject);

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
     sqls:='Delete from '+TableUsers+' where user_id='+
          Mainqr.FieldByName('user_id').asString;
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

//  but:=MessageBox(Handle,Pchar('������� ?'),'��������������',MB_YESNO+MB_ICONWARNING);
  if mr=mrYes then begin
    if not deleteRecord then begin
      ShowError(Application.Handle,'������������ <'+Mainqr.FieldByName('name').AsString+'> ������������.');
    end;
  end;
end;

procedure TfmUsers.bibFilterClick(Sender: TObject);
var
  fm: TfmEditUsers;
  filstr: string;
begin
 fm:=TfmEditUsers.Create(nil);
 try
  fm.Caption:=CaptionFilter;
  fm.lbPass.Enabled:=false;
  fm.edPass.Enabled:=false;
  fm.edPass.Color:=clBtnface;
  fm.chbHidePass.Enabled:=false;
  fm.chbAdmin.Enabled:=false;

  fm.btOk.OnClick:=fm.filterClick;

  if Trim(FindName)<>'' then fm.edName.Text:=FindName;

  fm.cbInString.Visible:=true;
  fm.cbInString.Checked:=FilterInSide;
  fm.ChangeFlag:=false;

  if fm.ShowModal=mrOk then begin

    FindName:=Trim(fm.edName.Text);
    isFindName:=Trim(FindName)<>'';
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

procedure TfmUsers.bibPrintClick(Sender: TObject);
begin
  CreateWordTableByGrid(Grid,Caption);
end;

procedure TfmUsers.MR(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

procedure TfmUsers.edSearchKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if not isValidKey(Char(Key)) then exit;
  if MainQr.IsEmpty then exit;
  if grid.SelectedField=nil then exit;
  MainQr.Locate('name',Trim(edSearch.Text),
                [loPartialKey,loCaseInsensitive]);
end;

procedure TfmUsers.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TfmUsers.bibCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfmUsers.GridTitleClick(Column: TColumn);
var
  fn: string;
  id: integer;
begin
  if not MainQr.Active then exit;
  if MainQr.RecordCount=0 then exit;
  Screen.Cursor:=crHourGlass;
  try
   fn:=Column.FieldName;
   if fn='' then fn:='flagadmin';
   id:=MainQr.fieldByName('user_id').asInteger;
   MainQr.Active:=false;
   MainQr.SQL.Clear;
   MainQr.SQL.Add('Select * from '+TableUsers+GetFilterString+' Order by '+fn);
   MainQr.Active:=true;
   MainQr.First;
   MainQr.Locate('user_id',id,[loCaseInsensitive]);
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TfmUsers.FormDestroy(Sender: TObject);
begin
  Grid.Free;
  if fsCreatedMDIChild in FormState then
   fmUsers:=nil;
end;

procedure TfmUsers.SetImageFilter;
begin
  bibFilter.Glyph.Assign(nil);
  bibFilter.Glyph.Width:=dm.IlMain.Width;
  bibFilter.Glyph.Height:=dm.IlMain.Height;
  if isFindName then begin
    dm.IlMain.draw(bibFilter.Glyph.Canvas,0,0,0,true);
  end else begin
    dm.IlMain.draw(bibFilter.Glyph.Canvas,0,0,1,true);
  end;
end;

procedure TfmUsers.LoadFilter;
var
  fi: TIniFile;
begin
 try
  fi:=TIniFile.Create(GetIniFileName);
  try
    FindName:=fi.ReadString('RBUsers','Name',FindName);
    FilterInside:=fi.ReadBool('RBUsers','Inside',FilterInside);
  finally
   fi.Free;
  end;
 except

 end; 
end;

procedure TfmUsers.SaveFilter;
var
  fi: TIniFile;
begin
 try
  fi:=TIniFile.Create(GetIniFileName);
  try
    fi.WriteString('RBUsers','Name',FindName);
    fi.WriteBool('RBUsers','Inside',FilterInside);
  finally
   fi.Free;
  end;
 except
 end; 
end;

function TfmUsers.GetFilterString: string;
var
  FilInSide: string;
  wherestr: string;
  addstr1,addstr2: string;
  and1: string;
begin
    Result:='';

    isFindName:=Trim(FindName)<>'';

    if isFindName or (not isEdit) then begin
     wherestr:=' where ';
    end else begin
    end;

    if FilterInside then FilInSide:='%';

     if isFindName then begin
        addstr1:=' Upper(name) like '+AnsiUpperCase(QuotedStr(FilInSide+FindName+'%'))+' ';

     end;

     if (isFindName and (not isEdit)) then
      and1:=' and ';

      Result:=wherestr+addstr1+and1+addstr2;

end;

procedure TfmUsers.ViewCount;
begin
 if MainQr.Active then
  lbCount.Caption:=ViewCountText+inttostr(GetRecordCount(Mainqr));
end;

procedure TfmUsers.MainqrAfterOpen(DataSet: TDataSet);
begin
  ViewCount;
end;

procedure TfmUsers.GridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);

  procedure DrawAdmin;
  var
    chk: Boolean;
    x: Integer;
  begin
    chk:=Mainqr.FieldByName('flagadmin').AsString='1';
    x:=rect.Left+(rect.Right-rect.Left) div 2;
    if not chk then Begin
     il.Draw(grid.Canvas,x-il.Width div 2,rect.Top,0,true);
    end else begin
     il.Draw(grid.Canvas,x-il.Width div 2,rect.Top,1,true);
    end;
  end;

begin
  if not Mainqr.Active then exit;
  if Mainqr.RecordCount=0 then exit;
  if column.Title.Caption='�������������' then begin
    DrawAdmin;
  end;
end;

procedure TfmUsers.GridDblClick(Sender: TObject);
begin
  if not Mainqr.Active then exit;
  if Mainqr.RecordCount=0 then exit;
  bibChangeClick(nil);
end;

function TfmUsers.UserNameExists(strName: String; var ID: Integer): Boolean;
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
   sqls:='Select * from '+TableUsers+' where name='''+Trim(strName)+'''';
   qr.SQL.Add(sqls);
   qr.Active:=true;
   if qr.recordCount=1 then begin
     ID:=qr.FieldByName('user_id').ASInteger;
     Result:=true;
   end;
  finally
   qr.Free;
   tr.Free;
   Screen.Cursor:=CrDefault;
  end;
end;

procedure TfmUsers.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfmUsers.FormResize(Sender: TObject);
begin
  edSearch.Width:=Self.Width-edSearch.Left-pnBut.Width-8;
end;

end.