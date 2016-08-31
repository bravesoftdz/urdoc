unit UDocTreeCarring;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls,UParentForm, Menus, UDm, ImgList,dbtables,
  db, Buttons, IBQuery, IBTable, IBCustomDataSet, FileCtrl, IBDatabase,
  IBServices;

type

  PInfoDoc=^TInfoDoc;
  TInfoDoc=packed record
    Name: String;
    Hint: String;
    ID: Integer;
    NodeID: Integer;
    NewForm: TForm;
  end;

  PInfoNode=^TInfoNode;
  TInfoNode=packed record
    Name: String;
    Hint: String;
    ID: Integer;
    ParentID: Integer;
    SortID: Integer;
  end;

  TfmDocTreeCarring = class(TfmParentForm)
    pnTV: TPanel;
    TV: TTreeView;
    pnTVBottom: TPanel;
    pnLV: TPanel;
    splLeft: TSplitter;
    LV: TListView;
    pnTopStatus: TPanel;
    lbTopStatus: TLabel;
    pmTVEdit: TPopupMenu;
    miEditFindInTV: TMenuItem;
    N6: TMenuItem;
    miNodeAdd: TMenuItem;
    miNodeAddSub: TMenuItem;
    miNodeChange: TMenuItem;
    miNodeDel: TMenuItem;
    miNodeDelAll: TMenuItem;
    pmTVView: TPopupMenu;
    miViewFindInTv: TMenuItem;
    N8: TMenuItem;
    miExpand: TMenuItem;
    miCollapse: TMenuItem;
    miExpandAll: TMenuItem;
    miCollapseAll: TMenuItem;
    miNodeChangeHint: TMenuItem;
    mmHint: TMemo;
    splBottom: TSplitter;
    pmLVEdit: TPopupMenu;
    miAddDoc: TMenuItem;
    miChangeDoc: TMenuItem;
    od: TOpenDialog;
    N1: TMenuItem;
    miLVView: TMenuItem;
    miLVLargeIcon: TMenuItem;
    miLVSmallIcon: TMenuItem;
    miLVList: TMenuItem;
    miLVReport: TMenuItem;
    ilLvSmall: TImageList;
    ilLVLarge: TImageList;
    miLVChangeHint: TMenuItem;
    miLVDelete: TMenuItem;
    miLVDeleteAll: TMenuItem;
    miLVDocument: TMenuItem;
    N3: TMenuItem;
    miLVChangeForm: TMenuItem;
    N2: TMenuItem;
    miLVDocLoad: TMenuItem;
    miLVDocSave: TMenuItem;
    sd: TSaveDialog;
    miLVFind: TMenuItem;
    N4: TMenuItem;
    pmLVView: TPopupMenu;
    miLVViewView: TMenuItem;
    miLVViewLargeIcon: TMenuItem;
    miLVViewSmallIcon: TMenuItem;
    miLVViewList: TMenuItem;
    miLVViewReport: TMenuItem;
    MenuItem6: TMenuItem;
    miLVViewFind: TMenuItem;
    pnBottom: TPanel;
    Panel3: TPanel;
    bibCancel: TBitBtn;
    miLVDocTest: TMenuItem;
    miAddDocFromDir: TMenuItem;
    miAddTypeDocDir: TMenuItem;
    pnFromBase: TPanel;
    grbBaseDir: TGroupBox;
    edBaseDir: TEdit;
    bibBaseDir: TBitBtn;
    bibRefresh: TBitBtn;
    IBDBCar: TIBDatabase;
    IBTCar: TIBTransaction;
    chbCloseTree: TCheckBox;
    ilTV: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure pmTVEditPopup(Sender: TObject);
    procedure miNodeAddClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure miNodeDelAllClick(Sender: TObject);
    procedure miNodeAddSubClick(Sender: TObject);
    procedure miNodeChangeClick(Sender: TObject);
    procedure TVEdited(Sender: TObject; Node: TTreeNode; var S: String);
    procedure miNodeDelClick(Sender: TObject);
    procedure miNodeChangeHintClick(Sender: TObject);
    procedure TVClick(Sender: TObject);
    procedure TVChange(Sender: TObject; Node: TTreeNode);
    procedure TVAdvancedCustomDrawItem(Sender: TCustomTreeView;
      Node: TTreeNode; State: TCustomDrawState; Stage: TCustomDrawStage;
      var PaintImages, DefaultDraw: Boolean);
    procedure pmLVEditPopup(Sender: TObject);
    procedure miAddDocClick(Sender: TObject);
    procedure miLVReportClick(Sender: TObject);
    procedure TVKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TVKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure miChangeDocClick(Sender: TObject);
    procedure LVEdited(Sender: TObject; Item: TListItem; var S: String);
    procedure miLVChangeHintClick(Sender: TObject);
    procedure miLVDeleteClick(Sender: TObject);
    procedure LVKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure miLVDeleteAllClick(Sender: TObject);
    procedure TVMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TVMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure TVMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TVEndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure TVDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure LVMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LVMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LVMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure LVEndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure TVDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure miLVChangeFormClick(Sender: TObject);
    procedure miLVDocFileClick(Sender: TObject);
    procedure miLVDocLoadClick(Sender: TObject);
    procedure miLVDocSaveClick(Sender: TObject);
    procedure LVDblClick(Sender: TObject);
    procedure miLVFindClick(Sender: TObject);
    procedure LVCustomDrawItem(Sender: TCustomListView; Item: TListItem;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure LVColumnClick(Sender: TObject; Column: TListColumn);
    procedure miEditFindInTVClick(Sender: TObject);
    procedure miViewFindInTvClick(Sender: TObject);
    procedure miExpandClick(Sender: TObject);
    procedure miCollapseClick(Sender: TObject);
    procedure miExpandAllClick(Sender: TObject);
    procedure miCollapseAllClick(Sender: TObject);
    procedure miLVViewLargeIconClick(Sender: TObject);
    procedure miLVDocTestClick(Sender: TObject);
    procedure miAddDocFromDirClick(Sender: TObject);
    procedure miAddTypeDocDirClick(Sender: TObject);
    procedure bibCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bibRefreshClick(Sender: TObject);
    procedure bibBaseDirClick(Sender: TObject);
    procedure chbCloseTreeClick(Sender: TObject);
  private
    NodeCur: TTreeNode;
    MouseLeftDown,MouseLeftDownLV: Boolean;
    LastNode: TTreeNode;
    FViewType: TViewType;
    glSortSubItem:integer;
    glSortForward:boolean;
    procedure SetViewType(Value: TViewType);
    procedure SortNodeUpdate(nd,ndParent: tTreeNode);
    procedure lvCompareStr(Sender: TObject; Item1, Item2: TListItem;
     Data: Integer; var Compare: Integer);{compare by str}
//    procedure SetMenuOperations(PM: TPopupMenu);
    function DocTest: Boolean;
  public
    notSort: Boolean;
    isConnect: Boolean;
    procedure SaveToFile;override;

    procedure ClearTreeView;
    procedure ClearListView;
    procedure ClearTreeViewBase;
    procedure ClearListViewBase(IDParent: Integer);
    procedure ActiveQuery;
    procedure FillTreeViewBase(ParentID: Integer);
    procedure FillListViewBase(NodeId: Integer);
    procedure ColumnCountChanged;
    
    function AddNodeToTreeView(ParentNode: TTreeNode; ID,ParentID,SortID: Integer;
                               NameStr,HintStr: String): TTreeNode;
    procedure DeleteNode(Node: TTreeNode);
    procedure DeleteSelectedInListView;
    procedure ViewNodeNew(nd: TTreeNode; Only: Boolean);
    function GetCheckedView: Integer;
    function GetCheckedDocument: Integer;
    procedure SetCheckedView(Index: Integer);
    procedure SetCheckedDocument(Index: Integer);
    procedure ExpandFirstNodes;
    procedure ConnectDataBaseNameCar;
    procedure DragDropFromDocTreeCarListView(nd: TTreeNode; TypeDocId: Integer; LVDest: TListView);
    procedure DragDropFromDocTreeCarTreeView(TVdest: TTreeView; nd: TTreeNode);
    function InsertIntoBase(DocIdCar,TypeDocId: Integer): Boolean;
    property ViewType: TViewType read FViewType write SetViewType;
  end;

var
  fmDocTreeCarring: TfmDocTreeCarring;
  DataBaseNameCar: string;


implementation


uses UMain, UHint, Mcompres, UDocReestr, UNewForm, UUtils, UServerConnect,
  UProgress, UDocTree, UCheckSum, tsvGradientLabel;

{$R *.DFM}


procedure TfmDocTreeCarring.FormCreate(Sender: TObject);
var
  lb: TtsvGradientLabel;
begin
  lb:=TtsvGradientLabel.Create(Self);
  lb.Parent:=lbTopStatus.Parent;
  lb.Align:=lbTopStatus.Align;
  lb.Font.Assign(lbTopStatus.Font);
  lb.FromColor:=clBtnShadow;
  lb.ToColor:=clBtnFace;
  lb.ColorCount:=ColorCount;
  lbTopStatus.Free;
  lb.Name:='lbTopStatus';
  lb.Caption:='';
  lbTopStatus:=TLabel(lb);
//  LoadFromIniDocTreeParams;
  Caption:=DocTreeCarringCaption;
  OnKeyDown:=fmMain.OnKeyDown;
  OnKeyPress:=fmMain.OnKeyPress;
  OnKeyUp:=fmMain.OnKeyUp;
  TV.OnKeyPress:=OnKeyPress;
  LV.OnKeyPress:=OnKeyPress;
  LV.OnKeyUp:=OnKeyUp;
  ViewType:=vtView;

  ColumnCountChanged;
end;

procedure TfmDocTreeCarring.SaveToFile;
begin

end;

procedure TfmDocTreeCarring.SetViewType(Value: TViewType);
begin
//  if Value=FViewType then exit;
  FViewType:=Value;
  case FViewType of
    vtView: begin
      TV.PopupMenu:=pmTVView;
      TV.ReadOnly:=true;
      LV.PopupMenu:=pmLVView;
      LV.MultiSelect:=true;
      LV.OnDblClick:=nil;
    end;
    vtEdit: begin
      TV.PopupMenu:=pmTVEdit;
      TV.ReadOnly:=false;
      LV.PopupMenu:=pmLVEdit;
      LV.MultiSelect:=true;
      LV.OnDblClick:=LVDblClick;
    end;
  end;
end;

procedure TfmDocTreeCarring.pmTVEditPopup(Sender: TObject);
var
  nd: TTreeNode;
begin
  nd:=Tv.Selected;
  if nd=nil then begin
   if Tv.Items.Count<>0 then begin
    miNodeDelAll.Enabled:=true;
    miEditFindInTV.Enabled:=true;
   end else begin
    miNodeDelAll.Enabled:=false;
    miEditFindInTV.Enabled:=false;
   end;
    miNodeAdd.Enabled:=true;
    miNodeAddSub.Enabled:=false;
    miNodeChange.Enabled:=false;
    miNodeDel.Enabled:=false;
    miNodeChangeHint.Enabled:=false;
    miAddTypeDocDir.Enabled:=true;
  end else begin
    miAddTypeDocDir.Enabled:=true;
    miNodeDelAll.Enabled:=true;
    miEditFindInTV.Enabled:=true;
    miNodeAdd.Enabled:=true;
    miNodeAddSub.Enabled:=true;
    miNodeChange.Enabled:=true;
    miNodeDel.Enabled:=true;
    miNodeChangeHint.Enabled:=true;
  end;
end;


procedure TfmDocTreeCarring.ClearListView;
var
  P: PInfoDoc;
  i: Integer;
  li: TListItem;
begin
  for i:=0 to LV.Items.Count-1 do begin
    li:=LV.Items.Item[i];
    P:=li.Data;
    if P.NewForm<>nil then begin
     P.NewForm.Close;
     RemoveLinksForm_ListItem(P.NewForm);
    end; 
    Dispose(P);
  end;
  try
   lv.Items.BeginUpdate;
   lv.Items.Clear;
  finally
   lv.Items.EndUpdate;
  end;
end;

procedure TfmDocTreeCarring.ClearTreeView;
var
  i: Integer;
  nd: TTreeNode;
  P: PInfoNode;
begin
  for i:=0 to TV.Items.Count-1 do begin
    nd:=TV.Items.Item[i];
    P:=nd.Data;
    Dispose(P);
  end;
  tv.Items.BeginUpdate;
  try
   tv.Items.Clear;
  finally
   tv.Items.EndUpdate;
  end;
  mmHint.Lines.Clear;
  lbTopStatus.Caption:='';
end;

procedure TfmDocTreeCarring.FormDestroy(Sender: TObject);
begin
  ClearTreeView;
  ClearListView;
  fmDocTreeCarring:=nil;
end;

procedure TfmDocTreeCarring.ActiveQuery;
begin
  if not IBDBCar.Connected then exit;

 Screen.Cursor:=crAppStart; 
 try
  ClearTreeView;
  lv.Visible:=false;
  tv.Visible:=false;
  try
   FillTreeViewBase(0);
  finally
   lv.Visible:=true;
   tv.Visible:=true;
  end;
  if TV.Items.Count<>0 then begin
    TV.FullCollapse;
    TV.Items.Item[0].Selected:=true;
   // ExpandFirstNodes;
    ViewNodeNew(TV.Items.Item[0],false);
  end;
 finally
  Screen.Cursor:=crDefault;
 end;

end;

procedure TfmDocTreeCarring.ClearTreeViewBase;
var
  qr: TIBQuery;
  sqls: string;
  tr: TIBTransaction;
begin
  Screen.Cursor:=crHourGlass;
  tr:=TIBTransaction.Create(nil);
  qr:=TIBQuery.Create(nil);
  try
   tr.AddDatabase(IBDBCar);
   IBDBCar.AddTransaction(tr);
   tr.Params.Text:=DefaultTransactionParamsTwo;
   qr.Database:=IBDBCar;
   qr.Transaction:=tr;
   qr.Transaction.Active:=true;

   sqls:='Delete from '+TableTypeDoc;
   qr.SQL.Add(sqls);
   qr.ExecSQL;
   qr.Transaction.CommitRetaining;
  finally
    qr.FRee;
    tr.Free;
    Screen.Cursor:=crDefault;
  end;
end;

procedure TfmDocTreeCarring.ClearListViewBase(IDParent: Integer);
var
  qr: TIBQuery;
  sqls: string;
  tr: TIBTransaction;
begin
  Screen.Cursor:=crHourGlass;
  tr:=TIBTransaction.Create(nil);
  qr:=TIBQuery.Create(nil);
  try
   tr.AddDatabase(IBDBCar);
   IBDBCar.AddTransaction(tr);
   tr.Params.Text:=DefaultTransactionParamsTwo;
   qr.Database:=IBDBCar;
   qr.Transaction:=tr;
   qr.Transaction.Active:=true;

    if IDParent>0 then begin
     sqls:='Delete from '+TableDoc+' where typedoc_id='+inttostr(IDParent);
    end else begin
     sqls:='Delete from '+TableDoc;
    end;
    qr.Transaction.Active:=true;
    qr.SQL.Add(sqls);
    qr.ExecSQL;
    qr.Transaction.CommitRetaining;
  finally
    qr.FRee;
    tr.Free;
    Screen.Cursor:=crDefault;
  end;
end;

function TfmDocTreeCarring.AddNodeToTreeView(ParentNode: TTreeNode; ID,ParentID,SortID: Integer;
                                   NameStr,HintStr: String): TTreeNode;
var
  P: PInfoNode;
begin
  New(P);
  P.Name:=NameStr;
  P.Hint:=HintStr;
  P.ID:=ID;
  P.ParentID:=ParentID;
  P.SortID:=SortID;
  Result:=Tv.Items.AddChild(ParentNode,NameStr);
  Result.Data:=P;
end;                                   

procedure TfmDocTreeCarring.miNodeDelAllClick(Sender: TObject);
var
  but: Integer;
begin
  but:=MessageBox(Handle,Pchar('����� ������� ��� �������.'+#13+
                               '������� ��� ?'),
                               '��������������',MB_ICONWARNING+MB_YESNO);
  case but of
    IDYES: begin
      if not isLinkOnReestrNew then begin
        ClearListViewBase(0);
        ClearListView;
        ClearTreeViewBase;
        ClearTreeView;
      end else begin
       ShowError(Application.Handle,'�� ���� �� �������� ���� ������ � �������.');
      end;
    end;
  end;
end;

procedure TfmDocTreeCarring.miNodeAddSubClick(Sender: TObject);
var
  nd,nd1: TTReeNode;
  P: PInfoNode;
  qr: TIBQuery;
  sqls: string;
  PName,PHint,PParentID: string;
  SortId: Integer;
  TypeDocId: Integer;
  tr: TIBTransaction;
begin
  nd:=Tv.Selected;
  if nd=nil then exit;
  tr:=TIBTransaction.Create(nil);
  qr:=TIBQuery.Create(nil);
  try
   P:=nd.Data;
   PParentID:=inttostr(P.ID);
   SortId:=GetNodeSortID(P.ID);
   TypeDocId:=GetMaxTypeDocID+1;
   PName:=DefaultNodeText+inttostr(TypeDocId);
   PHint:=PName;
   tr.AddDatabase(IBDBCar);
   IBDBCar.AddTransaction(tr);
   tr.Params.Text:=DefaultTransactionParamsTwo;
   qr.Database:=IBDBCar;
   qr.Transaction:=tr;
   qr.Transaction.Active:=true;

   sqls:='Insert into '+TableTypeDoc+' (name,hint,parent_id,sort_id)'+
        ' values ('''+PName+''','''+PHint+''','+PParentID+','+inttostr(SortId)+')';
   qr.SQL.Add(sqls);
   qr.ExecSQL;
   qr.Transaction.CommitRetaining;
   LastNodeID:=GetLastNodeID;
   nd1:=AddNodeToTreeView(nd,LastNodeID,P.ID,SortId,PName,PHint);
   nd1.ImageIndex:=0;
   nd1.SelectedIndex:=1;
   nd1.Selected:=true;
   nd1.EditText;
   ViewNodeNew(nd1,false);
   ChangeFlag:=true;
  finally
   qr.Free;
   tr.Free;
  end;
end;


procedure TfmDocTreeCarring.miNodeAddClick(Sender: TObject);
var
  P,POld: PInfoNode;
  nd,nd1: TTReeNode;
  qr: TIBQuery;
  sqls: string;
  PName,PHint,PParentID: string;
  PSortID: Integer;
  TypeDocId: Integer;
  tr: TIBTransaction;
begin
 Screen.Cursor:=crHourGlass;
 tr:=TIBTransaction.Create(nil);
 qr:=TIBQuery.Create(nil);
 try

  nd:=tv.Selected;
  if nd=nil then begin
    PParentID:='0';
    PSortID:=GetNodeSortID(strtoint(PParentID));
  end else begin
    if nd.Parent<>nil then begin
     POld:=nd.Parent.data;
     PParentID:=inttostr(POld.ID);
     PSortID:=GetNodeSortID(strtoint(PParentID));
    end else begin
     PParentID:='0';
     PSortID:=GetNodeSortID(strtoint(PParentID));
    end;

  end;
  TypeDocId:=GetMaxTypeDocID+1;
  PName:=DefaultNodeText+inttostr(TypeDocId);
  PHint:=PName;
  tr.AddDatabase(IBDBCar);
  IBDBCar.AddTransaction(tr);
  tr.Params.Text:=DefaultTransactionParamsTwo;
  qr.Database:=IBDBCar;
  qr.Transaction:=tr;
  qr.Transaction.Active:=true;

  sqls:='Insert into '+TableTypeDoc+' (name,hint,parent_id,sort_id)'+
        ' values ('''+PName+''','''+PHint+''','+PParentID+','+inttostr(PSortID)+')';
  qr.SQL.Add(sqls);
  qr.ExecSQL;
  qr.Transaction.CommitRetaining;
  LastNodeID:=GetLastNodeID;
  New(P);
  P.Name:=PName;
  P.Hint:=PHint;
  P.ID:=LastNodeID;
  P.SortID:=PSortID;
  nd1:=tv.Items.Add(nd,P.Name);
  nd1.Data:=P;
  nd1.ImageIndex:=0;
  nd1.SelectedIndex:=1;
  nd1.Selected:=true;
  nd1.EditText;
  ViewNodeNew(nd1,false);
  ChangeFlag:=true;
 finally
  qr.Free;
  tr.Free;
  Screen.Cursor:=crDefault;
 end;
end;

procedure TfmDocTreeCarring.FillTreeViewBase(ParentID: Integer);

  function GetParentNode(ParentId: Integer): TTreeNode;
  var
    i: Integer;
    nd: TTreeNode;
    P: PInfoNode;
  begin
    Result:=nil;
    for i:=0 to Tv.Items.Count-1 do begin
     nd:=Tv.Items.Item[i];
     if nd.data<>nil then begin
       P:=nd.data;
       if P.ID=ParentId then begin
        Result:=nd;
        exit;
       end;
     end;
    end;
  end;

var
  ID: Integer;
  ParentIDNew: string;
  Namestr,HintStr: string;
  SortID: String;
  SortIDNew: Integer;
  nd,nd1: TTreeNode;
  qr: TIBQuery;
  tr: TIBTransaction;
begin
  tv.Items.BeginUpdate;
  tr:=TIBTransaction.Create(nil);
  qr:=TIBQuery.Create(nil);
  try
   tr.AddDatabase(IBDBCar);
   IBDBCar.AddTransaction(tr);
   tr.Params.Text:=DefaultTransactionParamsTwo;
   qr.Database:=IBDBCar;
   qr.Transaction:=tr;
   qr.Transaction.Active:=true;

   qr.SQL.Add('Select * from '+TableTypeDoc+
              ' where parent_id='+inttostr(ParentID)+
              ' order by sort_id');
   qr.Active:=true;
   qr.First;
   while not qr.Eof do begin
    ID:=qr.FieldByName('typedoc_id').AsInteger;
    ParentIDNew:=qr.FieldByName('parent_id').AsString;
    Namestr:=qr.FieldByName('name').AsString;
    HintStr:=qr.FieldByName('hint').AsString;
    SortID:=qr.FieldByName('sort_id').AsString;
    if Trim(SortID)<>'' then begin
      SortIDNew:=strtoint(SortID);
    end else begin
      SortIDNew:=0;
    end;
    nd:=GetParentNode(StrToInt(ParentIDNew));
    nd1:=AddNodeToTreeView(nd,ID,Strtoint(ParentIDNew),SortIDNew,Namestr,HintStr);
    nd1.ImageIndex:=0;
    nd1.SelectedIndex:=1;
    SortNodeUpdate(nd1,nd);
    FillTreeViewBase(ID);
    qr.Next;
   end;
  finally
   qr.Free;
   tr.Free;
   tv.Items.EndUpdate;
  end;
end;


procedure TfmDocTreeCarring.miNodeChangeClick(Sender: TObject);
var
  nd: TTreeNode;
begin
  nd:=tv.Selected;
  if nd=nil then exit;
  nd.EditText;
  ChangeFlag:=true;
end;

procedure TfmDocTreeCarring.TVEdited(Sender: TObject; Node: TTreeNode;
  var S: String);
var
  P: PInfoNode;
  qr: TIBQuery;
  sqls: string;
  tr: TIBTransaction;
begin
  if Node.Data=nil then exit;
  if Trim(S)='' then begin
   ShowError(Application.Handle,DefaultNodeText+' �� ����� ���� ������.');
   S:=Node.Text;
   exit;
  end;
{  TypeDocId:=GetTypeDocID(S);
  if TypeDocId<>0 then begin
   ShowError(Application.Handle,'����� ��� ��� ����������.');
   S:=Node.Text;
   exit;
  end;}
  P:=Node.data;
  Screen.Cursor:=CrHourGlass;
  tr:=TIBTransaction.Create(nil);
  qr:=TIBQuery.Create(nil);
  try
   tr.AddDatabase(IBDBCar);
   IBDBCar.AddTransaction(tr);
   tr.Params.Text:=DefaultTransactionParamsTwo;
   qr.Database:=IBDBCar;
   qr.Transaction:=tr;
   qr.Transaction.Active:=true;

   sqls:='Update '+TableTypeDoc+' set name='''+S+''' where typedoc_id='+inttostr(P.ID);
   qr.SQL.Add(sqls);
   qr.ExecSQL;
   qr.Transaction.CommitRetaining;
   if Assigned(fmDocReestr) then
    fmDocReestr.ActiveQuery;
  finally
   qr.Free;
   tr.Free;
   Screen.Cursor:=CrDefault;
  end;
end;

procedure TfmDocTreeCarring.miNodeDelClick(Sender: TObject);
var
  nd: TTreeNode;
  mr: TModalResult;
begin
  nd:=TV.Selected;
  if nd=nil then exit;

  mr:=MessageDlg('����� ������� ��� ������� �� ����� ����.'+#13+
                               '������� <'+nd.text+'> ?',mtConfirmation,[mbYes,mbNo],-1);

  case mr of
    mrYes: begin
      if nd.Count<>0 then begin
        ShowError(Application.Handle,'�� ��� <'+nd.Text+'> ��������� ������ ����.');
      end else begin
        DeleteNode(nd);
      end;
    end;
  end;
end;

procedure TfmDocTreeCarring.DeleteNode(Node: TTreeNode);
var
  P: PInfoNode;
  qr: TIBQuery;
  sqls: string;
  tr: TIBTransaction;
begin
  if Node=nil then exit;
  P:=Node.Data;
  tr:=TIBTransaction.Create(nil);
  qr:=TIBQuery.Create(nil);
  Screen.Cursor:=crHourGlass;
  try
   tr.AddDatabase(IBDBCar);
   IBDBCar.AddTransaction(tr);
   tr.Params.Text:=DefaultTransactionParamsTwo;
   qr.Database:=IBDBCar;
   qr.Transaction:=tr;
   qr.Transaction.Active:=true;
   if not isLinkOnReestr(0,P.ID,false) then begin
    sqls:='Delete from '+TableDoc+' where typedoc_id='+inttostr(P.ID);
    qr.Transaction.Active:=true;
    qr.sql.Add(sqls);
    qr.ExecSQL;
    qr.Transaction.CommitRetaining;
    qr.sql.Clear;
    sqls:='Delete from '+TableTypeDoc+' where typedoc_id='+inttostr(P.ID);
    qr.sql.Add(sqls);
    qr.Transaction.Active:=true;
    qr.ExecSQL;
    qr.Transaction.CommitRetaining;
    ClearListView;
    Dispose(P);
    Node.Delete;
    ViewNodeNew(TV.Selected,false);
   end else begin
     ShowError(Application.Handle,'�� ���� �� �������� ���� ������ � �������.');
     exit;
   end;
  finally
   qr.Free;
   tr.Free;
   Screen.Cursor:=crDefault;
  end;
end;

procedure TfmDocTreeCarring.miNodeChangeHintClick(Sender: TObject);
var
  fm: TfmChangeHint;
  nd: TTreeNode;
  P: PInfoNode;
  qr: TIBQuery;
  sqls: string;
  tr: TIBTransaction;
begin
  nd:=Tv.Selected;
  if nd=nil then exit;
  fm:=TfmChangeHint.Create(nil);
  try
   P:=nd.Data;
   fm.Caption:=ChangeHintCaption;
   fm.mmNint.Lines.Text:=P.Hint;
   if fm.ShowModal=mrOk then begin
     Screen.Cursor:=crHourGlass;
     tr:=TIBTransaction.Create(nil);
     qr:=TIBQuery.Create(nil);
     try
      tr.AddDatabase(IBDBCar);
      IBDBCar.AddTransaction(tr);
      tr.Params.Text:=DefaultTransactionParamsTwo;
      qr.Database:=IBDBCar;
      qr.Transaction:=tr;
      qr.Transaction.Active:=true;

      sqls:='Update '+TableTypeDoc+' set hint='''+Trim(fm.mmNint.Lines.Text)+
            ''' where typedoc_id='+inttostr(P.ID);
      qr.SQL.Add(sqls);
      qr.ExecSQL;
      qr.Transaction.CommitRetaining;
      P.Hint:=Trim(fm.mmNint.Lines.Text);
      mmHint.Lines.Text:=P.Hint;
     finally
      qr.Free;
      tr.Free;
      Screen.Cursor:=crDefault;
     end;
   end;
  finally
   fm.Free;
  end;
end;

procedure TfmDocTreeCarring.ViewNodeNew(nd: TTreeNode; Only: Boolean);
var
  P: PInfoNode;
begin
  mmHint.Lines.Text:='';
  if nd=nil then exit;
  P:=nd.data;
  if not Only then
   if LastNode=nd then exit;
  LastNode:=nd;
  FillListViewBase(P.ID);
  if not isViewPath then begin
    lbTopStatus.Caption:=Format(fmtCaptionStatus,[P.Name,LV.Items.Count]);
  end else begin
    lbTopStatus.Caption:=Format(fmtCaptionStatus,[GetTreeRootFromTypeDoc(P.ID),LV.Items.Count]);
  end;  
  mmHint.Lines.Text:=P.Hint;
end;

procedure TfmDocTreeCarring.TVClick(Sender: TObject);
begin
   ViewNodeNew(Tv.Selected,false);
end;

procedure TfmDocTreeCarring.TVChange(Sender: TObject; Node: TTreeNode);
begin
//  ViewNodeNew(Node);
end;

procedure TfmDocTreeCarring.TVAdvancedCustomDrawItem(Sender: TCustomTreeView;
  Node: TTreeNode; State: TCustomDrawState; Stage: TCustomDrawStage;
  var PaintImages, DefaultDraw: Boolean);
begin
{// exit;
  if GetFocus<>tv.Handle then begin

    if Node=Tv.Selected then begin
     if not TV.IsEditing then begin
      brshStyle:=tv.Canvas.Brush.Style;
      tv.Canvas.Brush.Style:=bsSolid;
      tv.Canvas.Brush.Color:=clBtnFace;
      rt:=Node.DisplayRect(true);
      tv.Canvas.FillRect(rt);
      tv.Canvas.Brush.Style:=bsClear;
      tv.Canvas.TextOut(rt.Left+2,rt.top+1,node.text);
      tv.Canvas.Brush.Style:=brshStyle;
   //   tv.Canvas.DrawFocusRect(rt);
   //   DefaultDraw:=false;
     end;
    end else begin
     DefaultDraw:=true;
    end;
  end else DefaultDraw:=true;        }
end;

procedure TfmDocTreeCarring.pmLVEditPopup(Sender: TObject);
var
  li: TListItem;
begin
  li:=LV.Selected;
  if li=nil then begin
    if TV.Items.Count=0 then begin
      miAddDoc.Enabled:=false;
    end else begin
      miAddDoc.Enabled:=true;
    end;
    if LV.Items.Count=0 then begin
      miLVDeleteAll.Enabled:=false;
    end else begin
      miLVDeleteAll.Enabled:=true;
    end;
    miChangeDoc.Enabled:=false;
    miLVChangeHint.Enabled:=false;
    miLVDelete.Enabled:=false;
    miLVDocument.Enabled:=false;
    miLVChangeForm.Enabled:=false;
    miAddDocFromDir.Enabled:=true;
  end else begin
    miAddDoc.Enabled:=true;
    miAddDocFromDir.Enabled:=true;
    miChangeDoc.Enabled:=true;
    miLVChangeHint.Enabled:=true;
    miLVDelete.Enabled:=true;
    miLVDeleteAll.Enabled:=true;
    miLVDocument.Enabled:=true;
    miLVChangeForm.Enabled:=true;
  end;
end;

procedure TfmDocTreeCarring.miLVReportClick(Sender: TObject);
begin
  TMenuItem(Sender).Checked:=true;
  if Sender=miLVLargeIcon then begin
   LV.ViewStyle:=vsIcon;
   miLVViewLargeIcon.Checked:=true;
  end;
  if Sender=miLVSmallIcon then begin
   LV.ViewStyle:=vsSmallIcon;
   miLVViewSmallIcon.Checked:=true;
  end;
  if Sender=miLVList then begin
   LV.ViewStyle:=vsList;
   miLVViewList.Checked:=true;
  end;
  if Sender=miLVReport then begin
   LV.ViewStyle:=vsReport;
   miLVViewReport.Checked:=true;
  end; 
end;

procedure TfmDocTreeCarring.FillListViewBase(NodeId: Integer);
var
  qr: TIBQuery;
  sqls: string;
  li: TListItem;
  PList: PInfoDoc;
  tr: TIBTransaction;
  ms: TMemoryStream;
begin
  ClearListView;
  Screen.Cursor:=crHourGlass;
  tr:=TIBTransaction.Create(nil);
  qr:=TIBQuery.Create(nil);
  ms:=TMemoryStream.Create;
  lv.Items.BeginUpdate;
  try
   tr.AddDatabase(IBDBCar);
   IBDBCar.AddTransaction(tr);
   tr.Params.Text:=DefaultTransactionParamsTwo;
   qr.Database:=IBDBCar;
   qr.Transaction:=tr;
   qr.Transaction.Active:=true;

   sqls:='Select * from '+TableDoc+' where typedoc_id='+inttostr(NodeId);
   qr.sql.Add(sqls);
   qr.Active:=true;
   qr.First;
   while not qr.Eof do begin
    new(PList);
    PList.Name:=Trim(qr.FieldByName('Name').AsString);
    PList.Hint:=Trim(qr.FieldByName('Hint').AsString);
    PList.ID:=qr.FieldByName('doc_id').AsInteger;
    PList.NodeID:=qr.FieldByName('typedoc_id').AsInteger;
    PList.NewForm:=nil;
    li:=LV.Items.Add;
    li.Caption:=PList.Name;
    li.SubItems.Add(PList.Hint);
    li.SubItems.Add(qr.FieldByName('lastdate').AsString);
    ms.Clear;
    TBlobField(qr.fieldByName('DataDoc')).SaveToStream(ms);
    li.SubItems.Add(Format('%p',[Pointer(CalculateCheckSum(ms.Memory,ms.Size))]));
    
    li.data:=PList;
    qr.Next;
   end;
  finally
   ms.Free;
   qr.Free;
   tr.Free;
   lv.Items.EndUpdate;
   Screen.Cursor:=crDefault;
  end;
end;

procedure TfmDocTreeCarring.TVKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_UP,VK_DOWN,VK_LEFT,VK_RIGHT: ViewNodeNew(Tv.Selected,false);
  end;
  OnKeyUp(Sender,Key,Shift);
end;

procedure TfmDocTreeCarring.TVKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 case FViewType of
  vtEdit: begin
   case Key of
    VK_DELETE: begin
     if ssCtrl in Shift then begin
      miNodeDelClick(nil);
     end;
    end;
   end;
  end; 
 end;
 OnKeyDown(Sender,Key,Shift);
end;

procedure TfmDocTreeCarring.miChangeDocClick(Sender: TObject);
var
  li: TListItem;
begin
  li:=Lv.Selected;
  if li=nil then exit;
  li.EditCaption;
  miChangeDoc.Checked:=true;
end;

procedure TfmDocTreeCarring.LVEdited(Sender: TObject; Item: TListItem;
  var S: String);
var
  PList: PInfoDoc;
  qr: TIBQuery;
  sqls: string;
  tr: TIBTransaction;
begin
  if ITem.Data=nil then exit;
  if Trim(S)='' then begin
   ShowError(Application.Handle,'������������ ������� �� ����� ���� ������.');
   S:=Item.Caption;
   exit;
  end;
  PList:=Item.data;
  Screen.Cursor:=CrHourGlass;
  tr:=TIBTransaction.Create(nil);
  qr:=TIBQuery.Create(nil);
  try
   tr.AddDatabase(IBDBCar);
   IBDBCar.AddTransaction(tr);
   tr.Params.Text:=DefaultTransactionParamsTwo;
   qr.Database:=IBDBCar;
   qr.Transaction:=tr;
   qr.Transaction.Active:=true;

   sqls:='Update '+TableDoc+' set name='''+S+''' where doc_id='+inttostr(PList.ID);
   qr.SQL.Add(sqls);
   qr.ExecSQL;
   qr.Transaction.CommitRetaining;
   if Assigned(fmDocReestr) then
    fmDocReestr.ActiveQuery;
  finally
   qr.Free;
   tr.Free;
   Screen.Cursor:=CrDefault;
  end;
end;

procedure TfmDocTreeCarring.miLVChangeHintClick(Sender: TObject);
var
  fm: TfmChangeHint;
  li: TListItem;
  PList: PInfoDoc;
  qr: TIBQuery;
  sqls: string;
  tr: TIBTransaction;
begin
  li:=lv.Selected;
  if li=nil then exit;
  fm:=TfmChangeHint.Create(nil);
  try
   PList:=li.Data;
   fm.Caption:=ChangeHintCaption;
   fm.mmNint.Lines.Text:=PList.Hint;
   if fm.ShowModal=mrOk then begin
     Screen.Cursor:=crHourGlass;
     tr:=TIBTransaction.Create(nil);
     qr:=TIBQuery.Create(nil);
     try
      tr.AddDatabase(IBDBCar);
      IBDBCar.AddTransaction(tr);
      tr.Params.Text:=DefaultTransactionParamsTwo;
      qr.Database:=IBDBCar;
      qr.Transaction:=tr;
      qr.Transaction.Active:=true;

      sqls:='Update '+TableDoc+' set hint='''+Trim(fm.mmNint.Lines.Text)+
            ''' where doc_id='+inttostr(PList.ID);
      qr.Transaction.Active:=true;      
      qr.SQL.Add(sqls);
      qr.ExecSQL;
      qr.Transaction.CommitRetaining;
      PList.Hint:=Trim(fm.mmNint.Lines.Text);
      li.SubItems.Strings[0]:=PLIst.Hint;
      if Assigned(fmDocReestr) then
       fmDocReestr.ActiveQuery;
     finally
      qr.Free;
      tr.Free;
      Screen.Cursor:=crDefault;
     end;
   end;
   miLVChangeHint.Checked:=true;
  finally
   fm.Free;
  end;
end;

procedure TfmDocTreeCarring.miLVDeleteClick(Sender: TObject);
var
  li: TListItem;
  mr: TModalResult;
begin

  li:=LV.Selected;
  if li=nil then exit;
  mr:=MessageDlg('������� ���������� �������?',mtConfirmation,[mbYes,mbNo],-1);
  case mr of
    mrYes: begin
     DeleteSelectedInListView;
    end;
  end;
end;

procedure TfmDocTreeCarring.DeleteSelectedInListView;
var
  PList: PInfoDoc;
  qr: TIBQuery;
  sqls: string;
  i: Integer;
  li: TListItem;
  tr: TIBTransaction;
begin
 Screen.Cursor:=crHourGlass;
 tr:=TIBTransaction.Create(nil);
 qr:=TIBQuery.Create(nil);
 LV.Items.BeginUpdate;
 try

  tr.AddDatabase(IBDBCar);
  IBDBCar.AddTransaction(tr);
  tr.Params.Text:=DefaultTransactionParamsTwo;
  qr.Database:=IBDBCar;
  qr.Transaction:=tr;
  qr.Transaction.Active:=true;

  for i:=Lv.Items.Count-1 downto 0 do begin
   li:=Lv.Items.Item[i];
   if Li.Selected then begin
    PList:=li.data;
    if not isLinkOnReestr(PList.ID,0,true) then begin
     sqls:='Delete from '+TableDoc+' where doc_id='+inttostr(Plist.Id);
     qr.SQL.Clear;
     qr.Transaction.Active:=true;
     qr.SQL.Add(sqls);
     qr.ExecSQL;
     qr.Transaction.CommitRetaining;
     if Plist.NewForm<>nil then begin
       RemoveLinksForm_ListItem(Plist.NewForm);
       Plist.NewForm.Close;
     end;
     li.Delete;
     dispose(Plist);
    end else begin
      ShowError(Application.Handle,'�� ������ <'+li.caption+'> ���� ������ � �������.');
      exit;
    end;
   end;
  end;
 finally
  LV.Items.EndUpdate;
  qr.Free;
  tr.Free;
  Screen.Cursor:=crDefault;
 end;
end;

procedure TfmDocTreeCarring.LVKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 case FViewType of
  vtEdit: begin
   case Key of
    VK_DELETE: begin
     if ssCtrl in Shift then begin
      miLVDeleteClick(nil);
     end;
    end;
    VK_Return: begin
      LVDblClick(nil);
    end;
   end;
  end;
 end;
 if ssCtrl in Shift then begin
   if (Key=Word('A')) or (Key=Word('a')) then begin
    SelectAllInListView(LV);
   end;
 end;  
 OnKeyDown(Sender,Key,Shift);
end;

procedure TfmDocTreeCarring.miLVDeleteAllClick(Sender: TObject);
var
  nd: TTReeNode;
  P: PinfoNode;
  mr: TModalResult;
begin
  nd:=TV.Selected;
  if nd=nil then exit;
  P:=nd.data;

  mr:=MessageDlg('������� ��� ������� � ���� <'+nd.Text+'> ?',mtConfirmation,[mbYes,mbNo],-1);
  case mr of
    mrYes: begin
     if not isLinkOnReestr(0,P.Id,false) then begin
      ClearListViewBase(P.Id);
      ClearListView;
     end else begin
      ShowError(Application.Handle,'�� ���� �� �������� ���� ������ � �������.');
     end;
    end;
  end;
end;


procedure TfmDocTreeCarring.TVMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (Shift=[ssLeft])and(tv.Selected=tv.GetNodeAt(X,Y)) then begin
    MouseLeftDown:=true;
  end else MouseLeftDown:=false;
end;

procedure TfmDocTreeCarring.TVMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  nd: TTreeNode;
begin
   nd:=tv.GetNodeAt(X,Y);
   if nd=nil then begin
     exit;
   end;
   NodeCur:=nd;
  { if nd=tv.Selected then begin
     exit;
   end;   }
  { if (Shift=[ssLeft])and (MouseLeftDown) then begin
     tv.BeginDrag(true);
   end;       }
end;

procedure TfmDocTreeCarring.TVMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button=mbLeft then begin
   MouseLeftDown:=false;
  end;
end;

procedure TfmDocTreeCarring.TVEndDrag(Sender, Target: TObject; X, Y: Integer);

{   procedure UpdateSortId(ndSel: TTreeNode; ChangeParent: Boolean);
   var
     List: TList;
     i: Integer;
     nd: TTreeNode;
     P: PInfoNode;
   begin
     List:=TList.Create;
     try
      GetNodelistFromLevel(tv,ndSel.Level,ndSel.Parent,List);
      for i:=0 to List.Count-1 do begin
        nd:=List.Items[i];
        P:=nd.data;
        P.SortID:=i+1;
        if ChangeParent and (ndSel.Parent<>nil) then
         P.ParentID:=PInfoNode(ndSel.Parent.Data).ID;
        SetNodeSortID(P.ID,P.SortID,P.ParentID);
      end;
     finally
      List.Free;
     end;
   end;             }


{var
  ndCur,ndSel: TTreeNode;}
begin
  exit;
  {
  ndSel:=tv.Selected;
  if ndSel=nil then exit;
  ndCur:=tv.GetNodeAt(X,Y);
  if ndCur=nil then exit;
  if ndSel=ndCur then exit;
  if (ndSel.Level=ndCur.Level)and(ndSel.Parent=ndCur.Parent)then begin
    ndSel.MoveTo(ndCur,naInsert);
    UpdateSortId(ndSel,false);
  end else begin
   if ndSel.Level>=ndCur.Level then begin
    ndSel.MoveTo(ndCur,naAddChild);
    UpdateSortId(ndSel,true);
   end;
  end;
  ChangeFlag:=true;}
end;

procedure TfmDocTreeCarring.SortNodeUpdate(nd,ndParent: tTreeNode);

  function GetMaxidSort: Integer;
  var
   i: Integer;
   nd1: TTReeNode;
   list: TList;
  begin
    result:=1;
    if Ndparent<>nil then begin
     for i:=0 to Ndparent.Count-1 do begin
      nd1:=NDParent.Item[i];
      if nd1.data<>nil then begin
        if PInfoNode(nd1.data).SortID>result then begin
          result:=PInfoNode(nd1.data).SortID;
        end;
      end;
     end;
    end else begin
     list:=TList.Create;
     try
      GetNodelistFromLevel(TV,nd.Level,nd.Parent,List);
      for i:=0 to List.Count-1 do begin
       nd1:=List.Items[i];
       if nd1.data<>nil then begin
        if PInfoNode(nd1.data).SortID>result then begin
          result:=PInfoNode(nd1.data).SortID;
        end;
       end;
      end;
     finally
      list.free;
     end;
    end;
  end;

  function GetNodeFromIdSort(idsort: Integer): TTReeNode;
  var
    i: Integer;
    nd1: TTreeNode;
    list: TList;
  begin
   if NdParent<>nil then begin
    result:=NDParent.getFirstChild;
    for i:=0 to Ndparent.Count-1 do begin
      nd1:=NDParent.Item[i];
      if nd1.data<>nil then begin
        if PInfoNode(nd1.data).SortID>idsort then begin
          result:=nd1;
          exit;
        end;
      end;
    end;
   end else begin
     result:=TV.Items.Item[TV.Items.Count-1];
     list:=TList.Create;
     try
      GetNodelistFromLevel(TV,nd.Level,nd.parent,List);
      for i:=0 to List.Count-1 do begin
       nd1:=List.Items[i];
       if nd1.data<>nil then begin
        if PInfoNode(nd1.data).SortID>idsort then begin
          result:=nd1;
          exit;
        end;
       end;
      end;
     finally
      list.free;
     end;
   end;
  end;

var
  maxi: integer;
  nd1: TTreeNode;
begin
  if notSort then exit;
  tv.Items.BeginUpdate;
  try
   maxi:=GetMaxidSort;
   if maxi>PInfoNode(nd.data).SortID then begin
    nd1:=GetNodeFromIdSort(PInfoNode(nd.data).SortID);
    nd.Moveto(nd1,naInsert);
   end else begin
    nd1:=Tv.Items.AddChildObject(NDParent,nd.text,nd.data);
    nd.Moveto(nd1,naInsert);
    nd1.delete;
   end;
  finally
   tv.Items.EndUpdate;
  end;
end;

procedure TfmDocTreeCarring.TVDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
var
  ndCur,ndSel: TTreeNode;
begin
  Accept:=false;
  exit;
  if Sender=Source then begin
    ndSel:=tv.Selected;
    if ndSel=nil then exit;
    ndCur:=tv.GetNodeAt(X,Y);
    if ndCur=nil then exit;
    if ndSel.Level>=ndCur.Level then 
      Accept:=true;
  end;
  if Source=lv then begin
    if ViewType=vtEdit then
      Accept:=true
    else Accept:=false;
  end;
end;

procedure TfmDocTreeCarring.LVMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (Shift=[ssLeft]) then begin
    MouseLeftDownLV:=true;
  end else MouseLeftDownLV:=false;
end;

procedure TfmDocTreeCarring.LVMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button=mbLeft then begin
   MouseLeftDownLV:=false;
  end;
end;

procedure TfmDocTreeCarring.LVMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  li: TListItem;
begin
   li:=lv.Selected;
   if li=nil then begin
     exit;
   end;
  { if (Shift=[ssLeft])and (MouseLeftDownLV) then begin
     lv.BeginDrag(true);
   end;               }
end;

procedure TfmDocTreeCarring.LVEndDrag(Sender, Target: TObject; X, Y: Integer);

  procedure UpdateLists(ndCur: TTreeNode);
  var
    List: TList;
    i: Integer;
    li: TListItem;
    PList: PInfoDoc;
  begin
    list:=TList.Create;
    lv.Items.BeginUpdate;
    try
     GetSelectedInListView(LV,List);
     for i:=0 to List.Count-1 do begin
       li:=List.Items[i];
       PList:=li.Data;
       UpdateListsParentID(PList.ID,PInfoNode(ndCur.Data).ID);
       if PList.NewForm<>nil then begin
         RemoveLinksForm_ListItem(PList.NewForm);
         PList.NewForm.Close;
       end;
       li.Delete;
       dispose(PList);
     end;
    finally
     lv.Items.EndUpdate;
     List.Free;
    end;

  end;

var
  ndCur: TTreeNode;
begin
  if (Target<>nil)and(Target=tv) then begin
   ndCur:=NodeCur;
   if ndCur=nil then exit;
   UpdateLists(ndCur);
   ViewNodeNew(Tv.Selected,true);
  end;
end;

procedure TfmDocTreeCarring.TVDragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  if Source=lv then begin
    NodeCur:=TV.GetNodeAt(x,Y);
  end;
end;

procedure TfmDocTreeCarring.miAddDocClick(Sender: TObject);
var
  nd: TTreeNode;
  P: PInfoNode;
  PList: PInfoDoc;
  PlistName,PListHint: string;
  PListNodeId: Integer;
  PListId: Integer;
  li: TListITem;
  strFiles: TStringList;
begin
  od.Filter:=FilterDoc;
  if not od.Execute then exit;
  nd:=TV.Selected;
  if nd=nil then exit;
  P:=nd.data;
  strFiles:=TStringList.Create;
  try
   strFiles.Add(od.FileName);
   if not AppendToDoc(P.ID,strFiles,ConstAddDoc,false)then exit;
   PListName:=ExtractFileName(od.FileName);
   PlistHint:=PListName;
   PListNodeId:=P.ID;
   PListId:=GetMaxIDFromTableDoc(PListNodeId,PListName);
   new(PList);
   PList.Name:=PListName;
   PList.Hint:=PListHint;
   PList.ID:=PListId;
   PList.NodeID:=PListNodeId;
   PList.NewForm:=nil;
   li:=LV.Items.Add;
   li.Caption:=PList.Name;
   li.SubItems.Add(PListHint);
   li.Data:=PList;
   li.ImageIndex:=0;
  finally
   strFiles.Free;
  end;

end;

procedure TfmDocTreeCarring.miLVChangeFormClick(Sender: TObject);
begin
  if ExtractFormOrDocFile(LV,true,'') then  begin
    miLVChangeForm.Checked:=true;
  end;
end;

procedure TfmDocTreeCarring.miLVDocFileClick(Sender: TObject);
var
  lpStartupInfo: STARTUPINFO;
  lpProcessInformation: TProcessInformation;
begin
  if not ExtractFormOrDocFile(LV,false,TempDocFilePath) then exit;
  FillChar(lpStartupInfo,sizeof(STARTUPINFO),0);
  FillChar(lpProcessInformation,sizeof(TProcessInformation),0);
  if not CreateProcess(
    nil,	// pointer to name of executable module
    Pchar(TempDocFilePath),
    nil,	// pointer to process security attributes
    nil,	// pointer to thread security attributes
    false,	// handle inheritance flag
    CREATE_DEFAULT_ERROR_MODE,	// creation flags
    nil,	// pointer to new environment block
    nil,	// pointer to current directory name
    lpStartupInfo,	// pointer to STARTUPINFO
    lpProcessInformation 	// pointer to PROCESS_INFORMATION
   ) then exit;

end;

procedure TfmDocTreeCarring.miLVDocLoadClick(Sender: TObject);
var
  msOutDoc: TMemoryStream;
  tb: TIBTable;
  PList: PInfoDoc;
  li: TListITem;
  tr: TIBTransaction;
begin
  od.Filter:=FilterDoc;
  if not od.Execute then exit;
  li:=LV.Selected;
  if li=nil then exit;
  PList:=li.Data;
  if IsBadCodePtr(PList) then exit;
  Screen.Cursor:=crHourGlass;
  msOutDoc:=TMemoryStream.Create;
  try
   CompressAndCryptFile(od.FileName,msOutDoc);
   tr:=TIBTransaction.Create(nil);
   tb:=TIBTable.Create(nil);
   try
    tr.AddDatabase(IBDBCar);
    IBDBCar.AddTransaction(tr);
    tr.Params.Text:=DefaultTransactionParamsTwo;
    tb.Database:=IBDBCar;
    tb.Transaction:=tr;
    tb.Transaction.Active:=true;

    tb.TableName:=TableDoc;
    tb.Active:=true;
    if tb.RecordCount<>0 then begin
     msOutDoc.Position:=0;
     tb.Locate('doc_id',Plist.ID,[loCaseInsensitive]);
     tb.Edit;
     TBlobField(tb.FieldByName('DataDoc')).LoadFromStream(msOutDoc);
     tb.Post;
     tb.Transaction.CommitRetaining;
    end;
   finally
    tb.Free;
   end;
  finally
   msOutDoc.free;
   Screen.Cursor:=crDefault;
  end;
end;

procedure TfmDocTreeCarring.miLVDocSaveClick(Sender: TObject);
begin
  sd.Filter:=FilterDoc;
  if not sd.Execute then exit;
  if not ExtractFormOrDocFile(LV,false,sd.FileName) then exit;
end;

procedure TfmDocTreeCarring.LVDblClick(Sender: TObject);
begin
  if miChangeDoc.Checked then miChangeDoc.OnClick(nil);
  if miLVChangeHint.Checked then miLVChangeHint.OnClick(nil);
  if miLVChangeForm.Checked then miLVChangeForm.OnClick(nil);
  if miLVDocTest.Checked then miLVDocTest.OnClick(nil);

end;

procedure TfmDocTreeCarring.miLVFindClick(Sender: TObject);
begin
  FindOnListView(LV);
end;

procedure TfmDocTreeCarring.LVCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);

  procedure DrawItem;
  var
    rt: Trect;
    wd: Integer;
  begin
  //drBounds, drIcon, drLabel, drSelectBounds
    rt:=Item.DisplayRect(drLabel);
    with Sender.Canvas do begin
     brush.Style:=bsSolid;
     brush.Color:=clBtnFace;
     wd:=TextWidth(Item.Caption);
     InflateRect(rt,0,-1);
     rt.Right:=rt.Left+wd;
     FillRect(rt);
    end;
  end;

begin
{// exit;
  if (Item.Selected)and(not(cdsHot in State)) then
      DrawItem
  else DefaultDraw:=true;
  inherited;         }
end;

procedure TfmDocTreeCarring.LVColumnClick(Sender: TObject; Column: TListColumn);
var
 newSortItem:integer;
begin
 newSortItem:=Column.Index-1;
 if glSortSubItem=newSortItem then glSortForward:=not glSortForward
 else glSortForward:=true;
 glSortSubItem:=newSortItem;
 lv.OnCompare:=lvCompareStr;
 lv.AlphaSort;
end;

procedure TfmDocTreeCarring.lvCompareStr(Sender: TObject; Item1, Item2: TListItem;
  Data: Integer; var Compare: Integer);
begin
 if glSortSubItem>=0 then Compare:=CompareText(Item1.SubItems[glSortSubItem],Item2.SubItems[glSortSubItem])
 else Compare:=CompareText(Item1.Caption,Item2.Caption);
 if glSortForward=false then Compare:=-Compare;
end;

procedure TfmDocTreeCarring.miEditFindInTVClick(Sender: TObject);
begin
   FindOnTreeView(TV,Self);
end;

procedure TfmDocTreeCarring.miViewFindInTvClick(Sender: TObject);
begin
   FindOnTreeView(TV,Self);

end;

procedure TfmDocTreeCarring.miExpandClick(Sender: TObject);
var
  nd: TTreeNode;
begin
  nd:=tv.Selected;
  if nd=nil then exit;
  nd.Expand(true);
end;

procedure TfmDocTreeCarring.miCollapseClick(Sender: TObject);
var
  nd: TTreeNode;
begin
  nd:=tv.Selected;
  if nd=nil then exit;
  nd.Collapse(true);
end;

procedure TfmDocTreeCarring.miExpandAllClick(Sender: TObject);
begin
  TV.FullExpand;
end;

procedure TfmDocTreeCarring.miCollapseAllClick(Sender: TObject);
begin
  TV.FullCollapse;
end;

procedure TfmDocTreeCarring.miLVViewLargeIconClick(Sender: TObject);
begin
  TMenuItem(Sender).Checked:=true;
  if Sender=miLVViewLargeIcon then begin
   LV.ViewStyle:=vsIcon;
   miLVLargeIcon.Checked:=true;
  end;
  if Sender=miLVViewSmallIcon then begin
   LV.ViewStyle:=vsSmallIcon;
   miLVSmallIcon.Checked:=true;
  end;
  if Sender=miLVViewList then begin
   LV.ViewStyle:=vsList;
   miLVList.Checked:=true;
  end; 
  if Sender=miLVViewReport then begin
   LV.ViewStyle:=vsReport;
   miLVReport.Checked:=true;
  end;
end;

{procedure TfmDocTreeCarring.SetMenuOperations(PM: TPopupMenu);
begin
end;}

procedure TfmDocTreeCarring.miLVDocTestClick(Sender: TObject);
begin
  if DocTest then
   miLVDocTest.Checked:=true;
end;

function TfmDocTreeCarring.DocTest: Boolean;
var
  msOutForm: TMemoryStream;
  li: TListITem;
  fmNew: TfmNewForm;
  qr: TIBQuery;
  sqls: string;
  PList: PInfoDoc;
  List: TList;
  tr: TIBTransaction;
  Error2: Boolean;
begin
  result:=false;
  if LV.SelCount<>1 then exit;
  li:=lv.Selected;
  if li=nil then exit;
  PList:=li.Data;
  fmNew:=TfmNewForm.Create(nil);
  msOutForm:=TMemoryStream.Create;
  tr:=TIBTransaction.Create(nil);
  qr:=TIBQuery.Create(nil);
  List:=TList.Create;
  try
   Screen.Cursor:=crHourGlass;
   try

    tr.AddDatabase(IBDBCar);
    IBDBCar.AddTransaction(tr);
    tr.Params.Text:=DefaultTransactionParamsTwo;
    qr.Database:=IBDBCar;
    qr.Transaction:=tr;
    qr.Transaction.Active:=true;

    sqls:='Select * from '+TableDoc+' where doc_id='+inttostr(PList.ID);
    qr.SQL.Add(sqls);
    qr.Active:=true;
    TBlobField(qr.fieldByName('DataForm')).SaveToStream(msOutForm);
    msOutForm.Position:=0;
    ExtractObjectFromStream(msOutForm);
    msOutForm.Position:=0;
    FreeAllComponents(fmNew);
    Error2:=false;
    LoadControlFromStream(fmNew,msOutForm,Error2);
    if not Error2 then begin

      fmNew.OnKeyDown:=fmMain.OnKeyDown;
      fmNew.OnKeyPress:=fmMain.OnKeyPress;
      fmNew.OnKeyUp:=fmMain.OnKeyUp;
      fmNew.ViewType:=vtEdit;
      fmNew.ViewType:=vtView;
      fmNew.PrepeareControlsAfterLoad(fmNew.pnDesign);
      fmNew.bibOk.OnClick:=fmNew.bibOkClickTest;
      fmNew.bibCancel.OnClick:=fmNew.bibCancelClickTest;
      fmNew.bibOtlogen.OnClick:=fmNew.bibOtlogenClickTest;
  //    fmNew.LocateFirstFocusedControl;
    end; 

   finally
    Screen.Cursor:=crDefault;
   end;
   if not Error2 then begin

     fmNew.Hide;
     Result:=fmNew.ShowModal=mrOk;
   end;

  finally
   ClearWordObjectList(List);
   List.Free;
   msOutForm.Free;
   fmNew.Free;
   qr.Free;
   tr.Free;
  end;
end;

function TfmDocTreeCarring.GetCheckedView: Integer;
var
  i: Integer;
  mi: TmenuItem;
begin
  mi:=nil;
  case ViewType of
    vtView: mi:=miLVViewView;
    vtEdit: mi:=miLVView;
  end;
  Result:=-1;
  for i:=0 to mi.Count-1 do begin
    if mi.Items[i].Checked then begin
     Result:=I;
     exit;
    end;
  end;
end;

procedure TfmDocTreeCarring.SetCheckedView(Index: Integer);
var
  mi: TmenuItem;
begin
  mi:=nil;
  case ViewType of
    vtView: mi:=miLVViewView;
    vtEdit: mi:=miLVView;
  end;
  if mi.Count-1>=Index then begin
    mi.Items[Index].Click;
  end;
end;

function TfmDocTreeCarring.GetCheckedDocument: Integer;
var
  i: Integer;
  mi: TmenuItem;
begin
  mi:=nil;
  case ViewType of
    vtView: mi:=miLVDocument;
    vtEdit: mi:=miLVDocument;
  end;
  Result:=-1;
  for i:=0 to mi.Count-1 do begin
    if mi.Items[i].Checked then begin
     Result:=I;
     exit;
    end;
  end;
end;

procedure TfmDocTreeCarring.SetCheckedDocument(Index: Integer);
var
  mi: TmenuItem;
begin
  mi:=nil;
  case ViewType of
    vtView: mi:=miLVDocument;
    vtEdit: mi:=miLVDocument;
  end;
  if mi.Count-1>=Index then begin
    mi.Items[Index].Checked:=true;
  end;
end;

procedure TfmDocTreeCarring.miAddDocFromDirClick(Sender: TObject);
var
  Last: String;
begin
  Last:=GetDir(Application.Handle,'');
  if DirectoryExists(Last) then
   LoadDocFromDir('����������...',Last,true);
end;

procedure TfmDocTreeCarring.miAddTypeDocDirClick(Sender: TObject);
begin
  miAddDocFromDirClick(nil);
end;

procedure TfmDocTreeCarring.ExpandFirstNodes;
var
  nd: TTreeNode;
begin
  if Tv.Items.Count=0 then exit;
  nd:=Tv.Items[0];
  while nd<>nil do begin
    nd.Expand(false);
    nd:=nd.getNextSibling;
  end;

end;

procedure TfmDocTreeCarring.bibCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfmDocTreeCarring.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TfmDocTreeCarring.bibRefreshClick(Sender: TObject);
begin
  ActiveQuery;
end;

procedure TfmDocTreeCarring.bibBaseDirClick(Sender: TObject);
var
  fm: TfmServerConnect;
  Prot: TProtocol;
  SrvName: string;
begin
  fm:=TfmServerConnect.Create(nil);
  try
   GetProtocolAndServerName(DataBaseNameCar,Prot,SrvName);
   fm.SetParams(DataBaseNameCar,Prot,SrvName);
   if fm.ShowModal=mrOk then begin
    isConnect:=false;
    if ConnectServer(fm.ConnectString) then begin
     isConnect:=true;
     edBaseDir.Text:=fm.ConnectString;
     DataBaseNameCar:=edBaseDir.Text;
     ConnectDataBaseNameCar;
     ActiveQuery;
    end;
    Update; 
   end;
  finally
   fm.Free;
  end;
end;

procedure TfmDocTreeCarring.ConnectDataBaseNameCar;
begin
 if not isConnect then exit;
 Screen.Cursor:=crHourGlass;
 try
  IBTCar.Active:=false;
  IBDBCar.Connected:=false;
  IBDBCar.LoginPrompt:=false;
  IBDBCar.DatabaseName:=DataBaseNameCar;
  IBDBCar.Params.Clear;
  IBDBCar.Params.Add(DataBaseUserName);
  IBDBCar.Params.Add(DataBaseUserPass);
  IBDBCar.Params.Add(DataBaseCodePage);
  IBDBCar.Connected:=true;
  IBTCar.Active:=IBDBCar.Connected;
 finally
  Screen.Cursor:=crDefault;
 end; 
end;

procedure TfmDocTreeCarring.DragDropFromDocTreeCarListView(nd: TTreeNode; TypeDocId: Integer; LVDest: TListView);
var
  i: Integer;
  li: TListItem;
  P: PInfoDoc;
begin
  if LV.SelCount=0 then exit;
  BreakAnyProgress:=false;
  fmProgress.Caption:='����������...';
  fmProgress.lbProgress.Caption:=ConstAddDoc;
  fmProgress.gag.Position:=0;
  fmProgress.Visible:=true;
  fmProgress.Update;
  Screen.Cursor:=crHourGlass;
  try
    fmProgress.gag.Max:=LV.SelCount;
    for i:=0 to LV.Items.Count-1 do begin
     application.ProcessMessages;
     if BreakAnyProgress then exit;
     li:=LV.Items.Item[i];
     if li.Selected then begin
      P:=li.data;
      if P=nil then exit;
      SetPositonAndText(i+1,P.Name,ConstAddDoc,nil,fmProgress.gag.Max);
      InsertIntoBase(P.ID,TypeDocId);
     end;
    end;
  finally
   nd.MakeVisible;
   nd.Selected:=true;
   fmDocTree.ViewNodeNew(nd,true);
   fmProgress.Visible:=false;
   Screen.Cursor:=crDefault;
  end;
end;

function TfmDocTreeCarring.InsertIntoBase(DocIdCar,TypeDocId: Integer): Boolean;
var
    qrSource: TIBQuery;
    tbDest: TIBTable;
    sqls: string;
    msOut: TMemoryStream;
    tr,tr1: TIBTransaction;
begin
    Screen.Cursor:=crHourGlass;
    msOut:=TMemoryStream.Create;
    tr:=TIBTransaction.Create(nil);
    tr1:=TIBTransaction.Create(nil);
    qrSource:=TIBQuery.Create(nil);
    tbDest:=TIBTable.Create(nil);
    try
     Result:=false;
     tr.AddDatabase(IBDbCar);
     IBDbCar.AddTransaction(tr);
     tr.Params.Text:=DefaultTransactionParamsTwo;
     qrSource.Database:=IBDbCar;
     qrSource.Transaction:=tr;
     qrSource.Transaction.Active:=true;
     sqls:='Select * from '+TableDoc+' where doc_id='+inttostr(DocIdCar);
     qrSource.SQL.Add(sqls);
     qrSource.Active:=true;
     if qrSource.RecordCount<>1 then exit;

     tr1.AddDatabase(dm.IBDbase);
     dm.IBDbase.AddTransaction(tr1);
     tr1.Params.Text:=DefaultTransactionParamsTwo;

     tbDest.Database:=dm.IBDbase;
     tbDest.Transaction:=tr1;
     tbDest.Transaction.Active:=true;
     tbDest.TableName:=TableDoc;
     tbDest.Filter:=' typedoc_id=0 ';
     tbDest.Filtered:=true;
     tbDest.Active:=true;

     tbDest.Append;
     tbDest.FieldByName('typedoc_id').AsInteger:=TypeDocId;
     tbDest.FieldByName('name').AsString:=qrSource.FieldByName('name').AsString;
     tbDest.FieldByName('hint').AsString:=qrSource.FieldByName('hint').AsString;
     msOut.Clear;
     msOut.Position:=0;
     TBlobField(qrSource.FieldByName('datadoc')).SaveToStream(msOut);
     msOut.Position:=0;
     TBlobField(tbDest.FieldByName('datadoc')).LoadFromStream(msOut);
     msOut.Clear;
     msOut.Position:=0;
     TBlobField(qrSource.FieldByName('dataform')).SaveToStream(msOut);
     msOut.Position:=0;
     TBlobField(tbDest.FieldByName('dataform')).LoadFromStream(msOut);

     tbDest.FieldByName('doc_id').Required:=false;
     tbDest.FieldByName('lastdate').Required:=false;

     tbDest.Post;
     tbDest.Transaction.CommitRetaining;

     Result:=true;
    finally
     msOut.Free;
     qrSource.Free;
     tbDest.Free;
     tr1.Free;
     tr.FRee;
     Screen.Cursor:=crDefault;
    end;
end;

procedure TfmDocTreeCarring.chbCloseTreeClick(Sender: TObject);
begin
  pnTV.Visible:=chbCloseTree.Checked;
end;

procedure TfmDocTreeCarring.DragDropFromDocTreeCarTreeView(TVdest: TTreeView; nd: TTreeNode);

  procedure InsertToDoc(TypeDocId,TypeDocIdCar: Integer);
  var
    qrSource: TIBQuery;
    sqls: string;
    RecCount: Integer;
    i: Integer;
    tr: TIBTransaction;
  begin
    Screen.Cursor:=crHourGlass;
    tr:=TIBTransaction.Create(nil);
    qrSource:=TIBQuery.Create(nil);
    try
     tr.AddDatabase(IBDbCar);
     IBDbCar.AddTransaction(tr);
     tr.Params.Text:=DefaultTransactionParamsTwo;
     qrSource.Database:=IBDbCar;
     qrSource.Transaction:=tr;
     qrSource.Transaction.Active:=true;
     sqls:='Select doc_id,name from '+TableDoc+' where typedoc_id='+inttostr(TypeDocIdCar);
     qrSource.SQL.Add(sqls);
     qrSource.Active:=true;
     RecCount:=GetRecordCount(qrSource);
     fmProgress.gag.Max:=RecCount;
     i:=0;
     qrSource.First;
     while not qrSource.Eof do begin
       application.ProcessMessages;
       if BreakAnyProgress then exit;
       SetPositonAndText(i+1,qrSource.FieldByName('name').AsString,ConstAddDoc,nil,fmProgress.gag.Max);
       InsertIntoBase(qrSource.FieldByName('doc_id').AsInteger,TypeDocId);
       qrSource.Next;
       inc(i);
     end;
    finally
     qrSource.Free;
     tr.FRee;
     Screen.Cursor:=crDefault;
    end;
  end;

  procedure InsertFromTreeView(Node: TTreeNode; ndSource: TTreeNode);
  var
    i: Integer;
    ndS,ndDest: TTreeNode;
    PS: PInfoNode;
    PNode: PInfoNode;
    PDest: PInfoNode;
  begin
    for i:=0 to ndSource.Count-1 do begin
      ndS:=ndSource.Item[i];
      PS:=ndS.data;
      PNode:=Node.data;
      if PNode=nil then exit;
      if PS=nil then exit;
      new(PDest);
      ndDest:=TVDest.Items.AddChild(Node,PS.Name);
      ndDest.Data:=Pdest;
      Pdest.Name:=PS.Name;
      Pdest.Hint:=PS.Hint;
      Pdest.ParentID:=PNode.ID;
      Pdest.SortID:=i+1;
      Pdest.ID:=InsertToTypeDoc(PDest.Name,PDest.Hint,PDest.ParentID);
      InsertToDoc(PDest.ID,Ps.id);
      InsertFromTreeView(ndDest,nds);
    end;
  end;

var
  PDest,PSource: PInfoNode;
  newNode: TTreeNode;
  ndSource: TTreeNode;
begin
  if TVDest=nil then exit;
  ndSource:=TV.Selected;
  if ndSource=nil then exit;
  PSource:=ndSource.Data;
  if PSource=nil then exit;

 fmProgress.Caption:='����������...';
 fmProgress.lbProgress.Caption:=ConstAddDoc;
 fmProgress.gag.Position:=0;
 fmProgress.Visible:=true;
 fmProgress.Update;
 new(PDest);
 newNode:=TVDest.Items.AddChild(nd,PSource.Name);
 try
    newNode.Data:=Pdest;
    PDest.Name:=PSource.Name;
    PDest.Hint:=PSource.Hint;
    if nd=nil then begin
     PDest.ParentID:=0;
    end else begin
     PDest.ParentID:=PInfoNode(nd.Data).ID;
    end; 
    PDest.SortID:=1;
    PDest.ID:=InsertToTypeDoc(PDest.Name,PDest.Hint,PDest.ParentID);
    InsertToDoc(PDest.ID,PSource.ID);
    InsertFromTreeView(newNode,ndSource);
 finally
  newNode.MakeVisible;
  newNode.Selected:=true;
  fmDocTree.ViewNodeNew(newNode,true);
  newNode.Expand(false);
  fmProgress.Visible:=false;
 end;
end;

procedure TfmDocTreeCarring.ColumnCountChanged;
var
  lc: TListColumn;
begin
  if isViewDateInListView then begin
   if LV.Columns.Count<3 then begin
    lc:=LV.Columns.Add;
    lc.Caption:='���� � ����� ���������';
    lc.AutoSize:=true;
    lc.Width:=100;

    lc:=LV.Columns.Add;
    lc.Caption:='����������� �����';
    lc.AutoSize:=true;
    lc.Width:=60;
  end;  
  end else begin
    if LV.Columns.Count>3 then begin
     LV.Columns.Delete(3);
     LV.Columns.Delete(2);
    end; 
  end;
end;


end.