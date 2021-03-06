unit URBPeople;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, DBCtrls, Grids, DBGrids, Buttons,
  UEditPeople, UNewDbGrids, inifiles, IBCustomDataSet, IBQuery, IBTable,
  ImgList, Db,IBDatabase, UNewForm,TypInfo, mask, Ib,


  ComCtrls, Menus,
  DsnUnit, DsnSelect, DsnProp, DsnSubDp, tsvGrids, DsnList, UNewControls,
  DsnFunc, RXCalc, IBBlob;


type
  TfmRBPeople = class(TForm)
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
    bibReFill: TButton;
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
    procedure bibReFillClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edSearchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure bibPrintClick(Sender: TObject);
  private
    FindGenit: string;
    FindDativ: string;
    FindCreat: string;
    FindVinit: string;
    FindPredl: string;
    wt: TWinControl;
    IBTran: TIBTransaction;
    qr : TIBQuery;

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
    procedure GridKeyPress(Sender: TObject; var Key: Char);
  public
    FindNomin: string;
    isUpView: Boolean;
    Grid: TNewdbGrid;
    fm,fm_: TForm;
    procedure MR(Sender: TObject);
    procedure ActiveQuery;
    procedure LoadFilter;
    procedure InitRBPeople(wt_: TWinControl; fm_: TForm);
    procedure UpFill;
  end;

var
  fmRBPeople: TfmRBPeople;

implementation

uses Udm, UMain, UinUtils;

{$R *.DFM}

procedure TfmRBPeople.FormCreate(Sender: TObject);
begin
  isUpView:=false;
  
  tran.AddDatabase(dm.IBDbase);
  dm.IBDbase.AddTransaction(tran);
  tran.Params.Text:=DefaultTransactionParamsTwo;
  Mainqr.Transaction:=tran;

  IBTran:=TIBTransaction.Create(nil);
  qr:=TIBQuery.Create(nil);
  qr.Database:=dm.IBDbase;

  qr.Transaction:=IBTran;
  IBTran.AddDatabase(dm.IBDbase);
  dm.IBDbase.AddTransaction(IBTran);
  qr.Transaction.Active:=true;

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
  Grid.OnKeyPress:=GridKeyPress;

  OnKeyDown:=fmMain.OnKeyDown;
  OnKeyPress:=fmMain.OnKeyPress;
  OnKeyUp:=fmMain.OnKeyUp;
  Mainqr.Database:=dm.IBDbase;
end;

procedure TfmRBPeople.ActiveQuery;
var
 sqls: String;
 cl: TColumn;
begin
 SCreen.Cursor:=crHourGlass;
 try
    qr.Active:=false;
    qr.sql.Clear;
    sqls:='Select * from '+TableReFillQuote;
    qr.sql.Add(sqls);
    qr.Active:=true;
    qr.First;

    ds.DataSet:=nil;
    Mainqr.Active:=false;
    Mainqr.sql.Clear;
    sqls:='Select people_id, nomin, birthday from '+TablePeople+GetFilterString+' order by nomin';
    Mainqr.sql.Add(sqls);
    Mainqr.Active:=true;
    ds.DataSet:=Mainqr;
    SetImageFilter;
    ViewCount;
    if Grid.Columns.Count<>2 then begin
     cl:=Grid.Columns.Add;
     cl.FieldName:='nomin';
     cl.Title.Caption:='������������';
     cl.Width:=300;

     cl:=Grid.Columns.Add;
     cl.FieldName:='Birthday';
     cl.Title.Caption:='���� ��������';
     cl.Width:=100;

{     cl:=Grid.Columns.Add;
     cl.FieldName:='BirthPlace';
     cl.Title.Caption:='����� ��������';
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

     cl:=Grid.Columns.Add;
     cl.FieldName:='City';
     cl.Title.Caption:='�����';
     cl.Width:=100;

     cl:=Grid.Columns.Add;
     cl.FieldName:='Street';
     cl.Title.Caption:='�����';
     cl.Width:=100;

     cl:=Grid.Columns.Add;
     cl.FieldName:='House';
     cl.Title.Caption:='���';
     cl.Width:=100;

     cl:=Grid.Columns.Add;
     cl.FieldName:='Flat';
     cl.Title.Caption:='��������';
     cl.Width:=100;

     cl:=Grid.Columns.Add;
     cl.FieldName:='Cityzen';
     cl.Title.Caption:='�����������';
     cl.Width:=100;

     cl:=Grid.Columns.Add;
     cl.FieldName:='Sex';
     cl.Title.Caption:='���';
     cl.Width:=30;

     cl:=Grid.Columns.Add;
     cl.FieldName:='DocumentUDL';
     cl.Title.Caption:='�������� �������������� �������� (���)';
     cl.Width:=100;

     cl:=Grid.Columns.Add;
     cl.FieldName:='SeriasDUDL';
     cl.Title.Caption:='����� ���';
     cl.Width:=100;

     cl:=Grid.Columns.Add;
     cl.FieldName:='NumberDUDL';
     cl.Title.Caption:='����� ���';
     cl.Width:=100;

     cl:=Grid.Columns.Add;
     cl.FieldName:='CODDUDL';
     cl.Title.Caption:='��� ������������� ��������� ���';
     cl.Width:=100;

     cl:=Grid.Columns.Add;
     cl.FieldName:='WhoDealDUDL';
     cl.Title.Caption:='��� ����� ���';
     cl.Width:=100;

     cl:=Grid.Columns.Add;
     cl.FieldName:='DateDUDL';
     cl.Title.Caption:='���� ������ ���';
     cl.Width:=100;

     cl:=Grid.Columns.Add;
     cl.FieldName:='RegistartionFrom';
     cl.Title.Caption:='��������������� �';
     cl.Width:=100;

     cl:=Grid.Columns.Add;
     cl.FieldName:='DateDeath';
     cl.Title.Caption:='���� ������';
     cl.Width:=100;

     cl:=Grid.Columns.Add;
     cl.FieldName:='DocumentUFD';
     cl.Title.Caption:='�������� �������������� ���� ������ (����)';
     cl.Width:=100;

     cl:=Grid.Columns.Add;
     cl.FieldName:='WhoDealDUFD';
     cl.Title.Caption:='��� ����� ����';
     cl.Width:=100;

     cl:=Grid.Columns.Add;
     cl.FieldName:='SeriasDUFD';
     cl.Title.Caption:='����� ����';
     cl.Width:=100;

     cl:=Grid.Columns.Add;
     cl.FieldName:='NumberDUFD';
     cl.Title.Caption:='����� ����';
     cl.Width:=100;

     cl:=Grid.Columns.Add;
     cl.FieldName:='DateDUFD';
     cl.Title.Caption:='���� ������ ����';
     cl.Width:=100;}


    end;
  finally
    SCreen.Cursor:=crDefault;
  end;  
end;

procedure TfmRBPeople.bibAddClick(Sender: TObject);
var
  fm: TfmEditPeople;
  qr_: TIBQuery;
{  RetVal,}first: Boolean;
  valname: string;
  sqls, sqls1,sqls2: string;
  tr: TIBTransaction;
  ct: TComponent;
  tmps: string;

begin
 fm:=TfmEditPeople.Create(nil);
 try
  fm.Caption:=captionAdd;
  fm.bibOk.OnClick:=fm.AddAndChangeOkClick;
  if fm.ShowModal=mrOk then begin

    valname:=Trim(fm.edNomin.Text);
//    retval:=CaseNominExists(valname,id);

{    if retVal then begin
      ShowError(Application.handle,'���������� <'+valname+'> '+#13+
               valuePresent);
      Mainqr.Locate('people_id',id,[loCaseInsensitive]);
      exit;
    end;   }
    Screen.Cursor:=crHourGlass;
    tr:=TIBTransaction.Create(nil);
    qr_:=TIBQuery.Create(nil);
    try
     tr.AddDatabase(dm.IBDbase);
     dm.IBDbase.AddTransaction(tr);
     tr.Params.Text:=DefaultTransactionParamsTwo;
     qr_.Database:=dm.IBDbase;
     qr_.Transaction:=tr;
     qr_.Transaction.Active:=true;
     sqls:='Insert into '+TablePeople;
     first:=true;
     sqls1:='';
     sqls2:='';
     qr.First;
      while not qr.Eof do  begin
       try
         ct:=fm.FindComponent('ed'+Trim(Qr.FieldByName('FIELDNAME').AsString));
         tmps:=Trim(GetPropValue(ct,'Text'));
         if not ((tmps= '') or (tmps= '.  .')) then
            begin
                if (first) then
                   begin
                     sqls1:=sqls1 + Trim(Qr.FieldByName('FIELDNAME').AsString);
                     sqls2:=sqls2 + QuotedStr(Trim(GetPropValue(ct,'Text')));
                     first:=false;
                   end
                   else
                   begin
                     sqls1:=sqls1 + ',' + Trim(Qr.FieldByName('FIELDNAME').AsString);
                     sqls2:=sqls2 + ',' + QuotedStr(Trim(GetPropValue(ct,'Text')));
                   end;
            end;
       except
       end;
       qr.Next;
      end;
      sqls:=sqls+'('+sqls1+') values ('+sqls2+')';

     qr_.SQL.Add(sqls);
     try
      qr_.ExecSQL;
     except
      on E: EIBInterBaseError do begin
        TempStr:=TranslateIBError(E.Message);
        ShowError(Handle,TempStr);
      end;
     end;
     qr_.Transaction.CommitRetaining;
    finally
     qr_.Free;
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

procedure TfmRBPeople.bibChangeClick(Sender: TObject);
var
  fm: TfmEditPeople;
  qr_: TIBQuery;
  first: Boolean;
  sqls, sqls1, sqls2: string;
  tr: TIBTransaction;

  ct: TComponent;
  old_id: Integer;
  tmps: string;

  qrNew: TIbQuery;

begin
 if MainQr.RecordCount=0 then exit;
 fm:=TfmEditPeople.Create(nil);
 try

   old_id:=Mainqr.FieldByname('people_id').AsInteger;
   
   qrNew:=TIbQuery.Create(nil);
   tr:=TIBTransaction.Create(nil);
   try
     tr.AddDatabase(dm.IBDbase);
     dm.IBDbase.AddTransaction(tr);
     tr.Params.Text:=DefaultTransactionParamsTwo;
     qrNew.Database:=dm.IBDbase;
     qrNew.Transaction:=tr;
     qrNew.Active:=false;
     qrNew.Transaction.Active:=true;
     qrNew.sql.Clear;
     sqls:='Select * from '+TablePeople+' where people_id='+MainQr.FieldByName('people_id').AsString+' ';
     qrNew.sql.Add(sqls);
     qrNew.Active:=true;
     qr.First;
     while not qr.Eof do  begin
       try
         ct:=fm.FindComponent('ed'+Trim(Qr.FieldByName('FIELDNAME').AsString));
         SetPropValue(ct,'Text',qrNew.FieldByName(Qr.FieldByName('FIELDNAME').AsString).AsString);
       except
       end;
       qr.Next;
     end;
   finally
     tr.Free;
     qrNew.Free;
   end;

    fm.Caption:=captionChange;
    fm.bibOk.OnClick:=fm.AddAndChangeOkClick;
    fm.ChangeFlag:=false;

  if fm.ShowModal=mrOk then begin

    if not fm.ChangeFlag then exit;
    Screen.Cursor:=crHourGlass;
    tr:=TIBTransaction.Create(nil);
    qr_:=TIBQuery.Create(nil);
    try
     tr.AddDatabase(dm.IBDbase);
     dm.IBDbase.AddTransaction(tr);
     tr.Params.Text:=DefaultTransactionParamsTwo;
     qr_.Database:=dm.IBDbase;
     qr_.Transaction:=tr;
     qr_.Transaction.Active:=true;
     old_id:=MainQr.FieldByName('people_id').AsInteger;

     sqls:='Update '+TablePeople+ ' set ';
     first:=true;
     sqls1:='';
     sqls2:='';
     qr.First;
      while not qr.Eof do  begin
       try
         ct:=fm.FindComponent('ed'+Trim(Qr.FieldByName('FIELDNAME').AsString));
         tmps:=Trim(GetPropValue(ct,'Text'));
         if not ((tmps= '') or (tmps= '.  .')) then
            begin
                if (first) then
                   begin
                     sqls1:=sqls1 + Trim(Qr.FieldByName('FIELDNAME').AsString) +'='+
                     QuotedStr(Trim(GetPropValue(ct,'Text')));
                     first:=false;
                   end
                   else
                   begin
                     sqls1:=sqls1 + ', ' + Trim(Qr.FieldByName('FIELDNAME').AsString) +'='+
                     QuotedStr(Trim(GetPropValue(ct,'Text')));
                   end;
            end;
       except
       end;
       qr.Next;
      end;
      sqls:=sqls+sqls1+' where people_id='+inttostr(MainQr.FieldByName('people_id').AsInteger);
     qr_.SQL.Add(sqls);
     try
      qr_.ExecSQL;
     except
      on E: EIBInterBaseError do begin
        TempStr:=TranslateIBError(E.Message);
        ShowError(Handle,TempStr);
      end;
     end; 
     qr_.Transaction.CommitRetaining;
    finally
     qr_.Free;
     tr.Free;
     Mainqr.Active:=false;
     Mainqr.Active:=true;
//     Mainqr.Locate('nomin',valname,[loPartialKey,loCaseInsensitive]);
     ViewCount;
     Mainqr.Locate('people_id',old_id,[loCaseInsensitive]);
     Screen.Cursor:=crDefault;
    end;
  end;
 finally
  fm.Free;
 end;
end;

procedure TfmRBPeople.bibDelClick(Sender: TObject);

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
     sqls:='Delete from '+TablePeople+' where people_id='+
          Mainqr.FieldByName('people_id').asString;
     qr.sql.Add(sqls);
     qr.ExecSQL;
     qr.Transaction.CommitRetaining;
     Result:=true;
     Mainqr.Active:=false;
     Mainqr.Active:=true;
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

procedure TfmRBPeople.bibFilterClick(Sender: TObject);
var
  fm: TfmEditPeople;
  filstr: string;
  ct: TComponent;

begin
 fm:=TfmEditPeople.Create(nil);
 try
  fm.Caption:=CaptionFilter;
  fm.bibOk.OnClick:=fm.FilterOk;
  fm.isFilter:=true;

  qr.First;
    while not qr.Eof do  begin
    try
     if not ((AnsiUpperCase(Trim(Qr.FieldByName('FIELDNAME').AsString))='NOMIN') or
             (AnsiUpperCase(Trim(Qr.FieldByName('FIELDNAME').AsString))='GENIT') or
             (AnsiUpperCase(Trim(Qr.FieldByName('FIELDNAME').AsString))='DATIV') or
             (AnsiUpperCase(Trim(Qr.FieldByName('FIELDNAME').AsString))='CREAT') or
             (AnsiUpperCase(Trim(Qr.FieldByName('FIELDNAME').AsString))='VINIT') or
             (AnsiUpperCase(Trim(Qr.FieldByName('FIELDNAME').AsString))='PREDL')) then
             begin
              ct:=fm.FindComponent('ed'+Trim(Qr.FieldByName('FIELDNAME').AsString));
              SetPropValue(ct,'Enabled','False');
              SetPropValue(ct,'Color',clBtnFace);
             end;
    except
    end;
    qr.Next;
    end;
    fm.Repaint;

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

procedure TfmRBPeople.MR(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

procedure TfmRBPeople.edSearchKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if not isValidKey(Char(Key)) then exit;
  if MainQr.IsEmpty then exit;
  if grid.SelectedField=nil then exit;
  MainQr.Locate(grid.SelectedField.FullName,Trim(edSearch.Text),
                [loPartialKey,loCaseInsensitive]);
end;

procedure TfmRBPeople.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TfmRBPeople.bibCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfmRBPeople.GridTitleClick(Column: TColumn);
var
  fn: string;
  id: integer;
begin
  if not MainQr.Active then exit;
  if MainQr.RecordCount=0 then exit;
  Screen.Cursor:=crHourGlass;
  try
   fn:=Column.FieldName;
   id:=MainQr.fieldByName('people_id').asInteger;
   MainQr.Active:=false;
   MainQr.SQL.Clear;
   MainQr.SQL.Add('Select * from '+TablePeople+GetFilterString+' Order by '+fn);
   MainQr.Active:=true;
   MainQr.First;
   MainQr.Locate('people_id',id,[loCaseInsensitive]);
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TfmRBPeople.FormDestroy(Sender: TObject);
begin
  qr.Free;
  IBTran.Free;
  Grid.Free;
  if fsCreatedMDIChild in FormState then
    fmRBPeople:=nil;
end;

procedure TfmRBPeople.SetImageFilter;
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

procedure TfmRBPeople.LoadFilter;
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

procedure TfmRBPeople.SaveFilter;
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

function TfmRBPeople.GetFilterString: string;
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

procedure TfmRBPeople.ViewCount;
begin
 if MainQr.Active then
  lbCount.Caption:=ViewCountText+inttostr(GetRecordCount(Mainqr));
end;

procedure TfmRBPeople.MainqrAfterOpen(DataSet: TDataSet);
begin
  ViewCount;
end;

procedure TfmRBPeople.GridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
end;

procedure TfmRBPeople.GridDblClick(Sender: TObject);
begin
  if not Mainqr.Active then exit;
  if Mainqr.RecordCount=0 then exit;
  bibChangeClick(nil);
end;

function TfmRBPeople.CaseNominExists(strName: String; var ID: Integer): Boolean;
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
   sqls:='Select * from '+TablePeople+' where nomin='''+Trim(strName)+'''';
   qr.SQL.Add(sqls);
   qr.Active:=true;
   if qr.recordCount=1 then begin
     ID:=qr.FieldByName('people_id').ASInteger;
     Result:=true;
   end;
  finally
   qr.Free;
   tr.Free;
   Screen.Cursor:=CrDefault;
  end;
end;

procedure TfmRBPeople.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_F2: if pnSQL.Visible then bibAdd.Click;
    VK_F3: if pnSQL.Visible then bibChange.Click;
    VK_F4: if pnSQL.Visible then bibDel.Click;
//    VK_F5: bibRefresh.Click;
    VK_F6: bibFilter.Click;
    VK_UP,VK_DOWN: Grid.SetFocus;
  end;
  fmMain.FormKeyDown(Sender,Key,Shift);
end;

procedure TfmRBPeople.FormResize(Sender: TObject);
begin
  edSearch.Width:=Self.Width-edSearch.Left-pnBut.Width-8;
end;

procedure TfmRBPeople.InitRBPeople(wt_: TWinControl; fm_: TForm);
begin
  wt:=wt_;
  fm:=fm_;
//  Self.FormStyle:=fsNormal;
//  Self.ShowModal;
end;


procedure TfmRBPeople.bibReFillClick(Sender: TObject);

var
  List: TList;
  i: Integer;
  ct: TControl;
  str: string;
  qrNew: TIbQuery;
  tr: TIBTransaction;
  sqls: string;
begin

  qrNew:=TIbQuery.Create(nil);
  tr:=TIBTransaction.Create(nil);
  List:=TList.Create;
  try
   tr.AddDatabase(dm.IBDbase);
   dm.IBDbase.AddTransaction(tr);
   tr.Params.Text:=DefaultTransactionParamsTwo;
   qrNew.Database:=dm.IBDbase;
   qrNew.Transaction:=tr;
   qrNew.Active:=false;
   qrNew.Transaction.Active:=true;
   qrNew.sql.Clear;
   sqls:='Select * from '+TablePeople+' where people_id='+MainQr.FieldByName('people_id').AsString+' ';
   qrNew.sql.Add(sqls);
   qrNew.Active:=true;
   qr.First;
    wt.GetTabOrderList(List);
    for i:=0 to List.Count-1 do begin
     ct:=List.Items[i];
     if ct.Parent=wt then begin
      qr.First;
      while not qr.Eof do  begin
         try
         str:=AnsiUpperCase(AnsiString(GetStrProp(ct,'DocFieldName')));
         if (Pos(AnsiUpperCase(Qr.FieldByName('DOCFIELDNAME').AsString),str)>0) then
          begin
             try
              SetPropValue(ct,'Date',qrNew.FieldByName(Qr.FieldByName('FIELDNAME').AsString).AsDateTime);
              if (ct is TDateTimePicker) then begin
                TDateTimePicker(ct).Checked:=true;
              end;
             except
             end;
             try
//             if (ct.ClassName='TNewEdit') then
                SetStrProp(ct,'Text',qrNew.FieldByName(Qr.FieldByName('FIELDNAME').AsString).AsString);
             except
             end;
          end;

          except
          end;
       qr.Next;
      end;
     end; 
    end;
  finally
   List.Free;
   tr.Free;
   qrNew.Free;
  end;
  Close;
end;

procedure TfmRBPeople.UpFill;
var
  List: TList;
  i: Integer;
  ct: TControl;
  ct_:TComponent;
  str: string;
  tmps: string;
  fmModal: TfmEditPeople;


  qr_: TIBQuery;
  RetVal,first: Boolean;
  valname: string;
  sqls, sqls1,sqls2: string;
  id: Integer;
  tr: TIBTransaction;

begin

  fmModal:=TfmEditPeople.Create(nil);
  try
   List:=TList.Create;
   try
    wt.GetTabOrderList(List);
    for i:=0 to List.Count-1 do begin
     ct:=List.Items[i];
     if ct.Parent=wt then begin
      qr.First;
      while not qr.Eof do  begin
         str:=AnsiUpperCase(AnsiString(GetStrProp(ct,'DocFieldName')));
         if (Pos(AnsiUpperCase(Qr.FieldByName('DOCFIELDNAME').AsString),str)>0) then begin
             try
                  ct_:=fmModal.FindComponent('ed'+Trim(Qr.FieldByName('FIELDNAME').AsString));
                  SetPropValue(ct_,'Text',DateToStr(GetPropValue(ct,'Date')));
             except
             end;
             try
                  ct_:=fmModal.FindComponent('ed'+Trim(Qr.FieldByName('FIELDNAME').AsString));
                  SetPropValue(ct_,'Text',GetPropValue(ct,'Text'));
             except
             end;
         end;
         qr.Next;
      end;
     end; 
    end;
     fmModal.bibOk.OnClick:= fmModal.AddCaseOkClick;
    if fmModal.ShowModal=MrOk then begin
        valname:=Trim(fmModal.edNomin.Text);
        retval:=CaseNominExists(valname,id);
        if retVal then begin
          ShowError(Application.handle,'���������� <'+valname+'> '+#13+
                   valuePresent);
          Mainqr.Locate('people_id',id,[loCaseInsensitive]);
          exit;
        end;
        Screen.Cursor:=crHourGlass;
        tr:=TIBTransaction.Create(nil);
        qr_:=TIBQuery.Create(nil);
        try
         tr.AddDatabase(dm.IBDbase);
         dm.IBDbase.AddTransaction(tr);
         tr.Params.Text:=DefaultTransactionParamsTwo;
         qr_.Database:=dm.IBDbase;
         qr_.Transaction:=tr;
         qr_.Transaction.Active:=true;
         sqls:='Insert into '+TablePeople;
         first:=true;
         sqls1:='';
         sqls2:='';
         qr.First;
          while not qr.Eof do  begin
           try
             ct_:=fmModal.FindComponent('ed'+Trim(Qr.FieldByName('FIELDNAME').AsString));
             tmps:=Trim(GetPropValue(ct_,'Text'));
             if not ((tmps= '') or (tmps= '.  .')) then
                begin
                    if (first) then
                       begin
                         sqls1:=sqls1 + Trim(Qr.FieldByName('FIELDNAME').AsString);
                         sqls2:=sqls2 + QuotedStr(Trim(tmps));
                         first:=false;
                       end
                       else
                       begin
                         sqls1:=sqls1 + ',' + Trim(Qr.FieldByName('FIELDNAME').AsString);
                         sqls2:=sqls2 + ',' + QuotedStr(Trim(tmps));
                       end;
                end;
           except
           end;
           qr.Next;
          end;
          sqls:=sqls+'('+sqls1+') values ('+sqls2+')';

         qr_.SQL.Add(sqls);
         qr_.ExecSQL;
         qr_.Transaction.CommitRetaining;
        finally
         qr_.Free;
         tr.Free;
         Mainqr.Active:=false;
         Mainqr.Active:=true;
         Mainqr.Locate('nomin',valname,[loPartialKey,loCaseInsensitive]);
         ViewCount;
         Screen.Cursor:=crDefault;
        end;
    end;
  finally
   List.Free;
  end;
 finally
   fmModal.Free;
 end; 
end;

procedure TfmRBPeople.FormActivate(Sender: TObject);
begin
  if isUpView then begin
    UpFill;
    isUpView:=false;
  end;
end;

procedure TfmRBPeople.GridKeyPress(Sender: TObject; var Key: Char);
begin
  if isValidKey(Key) then begin
   edSearch.SetFocus;
   edSearch.Text:=Key;
   edSearch.SelStart:=Length(edSearch.Text);
   if Assigned(edSearch.OnKeyPress) then
    edSearch.OnKeyPress(Sender,Key);
  end;
end;


procedure TfmRBPeople.edSearchKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_UP,VK_DOWN: Grid.SetFocus;
  end;
  FormKeyDown(Sender,Key,Shift);
end;

procedure TfmRBPeople.bibPrintClick(Sender: TObject);
begin
  CreateWordTableByGrid(Grid,Caption);
end;

end.
