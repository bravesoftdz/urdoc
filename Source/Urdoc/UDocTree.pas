unit UDocTree;

interface

{$I def.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls,UParentForm, Menus, UDm, ImgList,dbtables,
  db, Buttons, IBQuery, IBTable, IBCustomDataSet, FileCtrl,IBDatabase;

type

  PInfoDoc=^TInfoDoc;
  TInfoDoc=packed record
    Name: String;
    Hint: String;
    ID: Integer;
    NodeID: Integer;
    NotarialActionID: Integer;
    RenovationID: Integer;
    SortNum: Integer;
    Summ: Double;
  end;

  PInfoNode=^TInfoNode;
  TInfoNode=packed record
    Name: String;
    Hint: String;
    ID: Integer;
    ParentID: Integer;
    SortID: Integer;
  end;

  TfmDocTree = class(TfmParentForm)
    pnTV: TPanel;
    TV: TTreeView;
    pnTVBottom: TPanel;
    pnLV: TPanel;
    splLeft: TSplitter;
    LV: TListView;
    ilTV: TImageList;
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
    bibOk: TBitBtn;
    bibCancel: TBitBtn;
    miLVDocTest: TMenuItem;
    miAddDocFromDir: TMenuItem;
    miAddTypeDocDir: TMenuItem;
    miViewDoc: TMenuItem;
    miViewDocView: TMenuItem;
    N5: TMenuItem;
    pnTopStatus: TPanel;
    lbTopStatus: TLabel;
    Panel1: TPanel;
    bibView: TBitBtn;
    miLoadForm: TMenuItem;
    miSaveForm: TMenuItem;
    miLoadDoc: TMenuItem;
    miSaveDoc: TMenuItem;
    N7: TMenuItem;
    miViewSearchDoc: TMenuItem;
    miEditSearchDoc: TMenuItem;
    pmCopyMove: TPopupMenu;
    miMoveDoc: TMenuItem;
    miCopyDoc: TMenuItem;
    N3: TMenuItem;
    miCancelDoc: TMenuItem;
    tmViewDoc: TTimer;
    miSaveToDir: TMenuItem;
    miLoadDir: TMenuItem;
    N9: TMenuItem;
    miSetNotarialAction: TMenuItem;
    miSetRenovation: TMenuItem;
    miSetRenovationNull: TMenuItem;
    miSetNotarialActionNull: TMenuItem;
    StatusBar1: TStatusBar;
    miSetSortNum: TMenuItem;
    miSetSumm: TMenuItem;
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
    procedure miLVDocFileClick(Sender: TObject);
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
    procedure LVDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure LVDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure miViewDocClick(Sender: TObject);
    procedure miViewDocViewClick(Sender: TObject);
    procedure bibViewClick(Sender: TObject);
    procedure miLVChangeFormClick(Sender: TObject);
    procedure miLoadDocClick(Sender: TObject);
    procedure miSaveDocClick(Sender: TObject);
    procedure miLoadFormClick(Sender: TObject);
    procedure miSaveFormClick(Sender: TObject);
    procedure miViewSearchDocClick(Sender: TObject);
    procedure miMoveDocClick(Sender: TObject);
    procedure miCopyDocClick(Sender: TObject);
    procedure LVEnter(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure bibViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tmViewDocTimer(Sender: TObject);
    procedure miSetNotarialActionClick(Sender: TObject);
    procedure miSetRenovationClick(Sender: TObject);
    procedure miSetRenovationNullClick(Sender: TObject);
    procedure miSetNotarialActionNullClick(Sender: TObject);
    procedure miSetSortNumClick(Sender: TObject);
    procedure miSetSummClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure miLoadDirClick(Sender: TObject);
    procedure miSaveToDirClick(Sender: TObject);
  private
    ListOpenDocs: TStringList;
    CopyMoveNode: TTreeNode;
    NodeCur: TTreeNode;

    MouseLeftDown,MouseLeftDownLV: Boolean;
    LastNode: TTreeNode;
    FViewType: TViewType;
    glSortSubItem:integer;
    glSortForward:boolean;
    procedure SetViewType(Value: TViewType);
    procedure SortNodeUpdate(nd,ndParent: tTreeNode);
    procedure lvCompareStr(Sender: TObject; Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
    procedure lvCompareInt(Sender: TObject; Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
//    procedure SetMenuOperations(PM: TPopupMenu);
    function DocTest: Boolean;
  public
    notSort: Boolean;
    procedure SaveToFile;override;

    procedure ClearTreeView;
    procedure ClearListView;
    procedure ClearTreeViewBase;
    procedure ClearListViewBase(IDParent: Integer);
    procedure ActiveQuery;
    procedure FillTreeViewBase(ParentID: Integer);
    procedure FillListViewBase(NodeId: Integer);
    
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
    function DocView: Boolean;
    procedure ColumnCountChanged;
    function GetNodeByTypeDocId(TypeDocId: Integer): TTreeNode;
    function GetListItemByDocId(DocId: Integer): TListItem;
    function ViewDoc(TypeDocId, DocId: Integer): Boolean;
    property ViewType: TViewType read FViewType write SetViewType;
  end;

var
  fmDocTree: TfmDocTree;


implementation


uses UMain, UHint, Mcompres, UDocReestr, UNewForm, UUtils, UDocTreeCarring,
  USearchDoc, UProgress, UCheckSum, tsvGradientLabel, URBNotarialAction,
  URBRenovation, UInputSortNum;

{$R *.DFM}


procedure TfmDocTree.FormCreate(Sender: TObject);
var
  lb: TtsvGradientLabel;
begin
  miLoadDir.Visible:=FAdminPresent;
  miSaveToDir.Visible:=FAdminPresent;

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
  LoadFromIniDocTreeParams;
  Caption:=DocTreeCaption;
  OnKeyDown:=fmMain.OnKeyDown;
  OnKeyPress:=fmMain.OnKeyPress;
  OnKeyUp:=fmMain.OnKeyUp;
  TV.OnKeyPress:=OnKeyPress;
  LV.OnKeyPress:=OnKeyPress;
  LV.OnKeyUp:=OnKeyUp;
  ColumnCountChanged;
  ListOpenDocs:=TStringList.Create;
end;

procedure TfmDocTree.SaveToFile;
begin

end;

procedure TfmDocTree.SetViewType(Value: TViewType);
begin
//  if Value=FViewType then exit;
  FViewType:=Value;
  case FViewType of
    vtView: begin
      TV.PopupMenu:=pmTVView;
      TV.ReadOnly:=true;
      LV.PopupMenu:=pmLVView;
      LV.MultiSelect:=false;
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

procedure TfmDocTree.pmTVEditPopup(Sender: TObject);
var
  nd: TTreeNode;
begin
  nd:=Tv.Selected;
  if nd=nil then begin
   if Tv.Items.Count<>0 then begin
    miNodeDelAll.Enabled:=true;
    miEditFindInTV.Enabled:=true;
    miEditSearchDoc.Enabled:=true;
   end else begin
    miNodeDelAll.Enabled:=false;
    miEditFindInTV.Enabled:=false;
    miEditSearchDoc.Enabled:=false;
   end;
    miNodeAdd.Enabled:=true;
    miNodeAddSub.Enabled:=false;
    miNodeChange.Enabled:=false;
    miNodeDel.Enabled:=false;
    miNodeChangeHint.Enabled:=false;
    miAddTypeDocDir.Enabled:=true;
  end else begin
    miEditSearchDoc.Enabled:=true;
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


procedure TfmDocTree.ClearListView;
var
  P: PInfoDoc;
  i: Integer;
  li: TListItem;
begin
  for i:=0 to LV.Items.Count-1 do begin
    li:=LV.Items.Item[i];
    P:=li.Data;
    Dispose(P);
  end;
  try
   lv.Items.BeginUpdate;
   lv.Items.Clear;
  finally
   lv.Items.EndUpdate;
  end;
end;

procedure TfmDocTree.ClearTreeView;
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

procedure TfmDocTree.FormDestroy(Sender: TObject);
begin
  ClearTreeView;
  ClearListView;
  ListOpenDocs.Free;
end;

procedure TfmDocTree.ActiveQuery;
begin
 Screen.Cursor:=crHourGlass;
 try
  ClearTreeView;
  tv.Visible:=false;
  LV.Visible:=false;
  try
   FillTreeViewBase(0);
  finally
   tv.Visible:=true;
   LV.Visible:=true;
  end;
  if TV.Items.Count<>0 then begin
    TV.FullCollapse;
    TV.Items.Item[0].Selected:=true;
//    ExpandFirstNodes;
    ViewNodeNew(TV.Items.Item[0],false);
  end;
 finally
  Screen.Cursor:=crDefault;
 end; 
end;

procedure TfmDocTree.ClearTreeViewBase;
var
  qr: TIBQuery;
  sqls: string;
  tr: TIBTransaction;
begin
  Screen.Cursor:=crHourGlass;
  tv.Items.BeginUpdate;
  tr:=TIBTransaction.Create(nil);
  qr:=TIBQuery.Create(nil);
  try
   tr.AddDatabase(dm.IBDbase);
   dm.IBDbase.AddTransaction(tr);
   tr.Params.Text:=DefaultTransactionParamsTwo;
   qr.Database:=dm.IBDbase;
   qr.Transaction:=tr;
   qr.Transaction.Active:=true;
   sqls:='Delete from '+TableTypeDoc;
   qr.Transaction.Active:=true;
   qr.SQL.Add(sqls);
   qr.ExecSQL;
   qr.Transaction.CommitRetaining;
  finally
    qr.FRee;
    tr.Free;
    tv.Items.EndUpdate;
    Screen.Cursor:=crDefault;
  end;
end;

procedure TfmDocTree.ClearListViewBase(IDParent: Integer);
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

function TfmDocTree.AddNodeToTreeView(ParentNode: TTreeNode; ID,ParentID,SortID: Integer;
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

procedure TfmDocTree.miNodeDelAllClick(Sender: TObject);
var
  mr: TModalResult;
begin
  mr:=MessageDlg('����� ������� ��� �������.'+#13+
                               '������� ��� ?',mtConfirmation,[mbYes,mbNo],-1);

  case mr of
    mrYes: begin
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

procedure TfmDocTree.miNodeAddSubClick(Sender: TObject);
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
   tr.AddDatabase(dm.IBDbase);
   dm.IBDbase.AddTransaction(tr);
   tr.Params.Text:=DefaultTransactionParamsTwo;
   qr.Database:=dm.IBDbase;
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


procedure TfmDocTree.miNodeAddClick(Sender: TObject);
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
  tr.AddDatabase(dm.IBDbase);
  dm.IBDbase.AddTransaction(tr);
  tr.Params.Text:=DefaultTransactionParamsTwo;
  qr.Database:=dm.IBDbase;
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

procedure TfmDocTree.FillTreeViewBase(ParentID: Integer);

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
  isCheck: Boolean;
  tr: TIBTransaction;
begin
//  Screen.Cursor:=crHourGlass;
  tr:=TIBTransaction.Create(nil);
  qr:=TIBQuery.Create(nil);
  try
   tr.AddDatabase(dm.IBDbase);
   dm.IBDbase.AddTransaction(tr);
   tr.Params.Text:=DefaultTransactionParamsTwo;
   qr.Database:=dm.IBDbase;
   qr.Transaction:=tr;
   qr.Transaction.Active:=true;
   qr.SQL.Add('Select * from '+TableTypeDoc+
              ' where parent_id='+inttostr(ParentID)+
              ' order by sort_id');
   qr.Active:=true;
   qr.First;
   while not qr.Eof do begin

    Namestr:=Trim(qr.FieldByName('name').AsString);

    isCheck:=true;
    
    if isCheck then begin
     ID:=qr.FieldByName('typedoc_id').AsInteger;
     ParentIDNew:=qr.FieldByName('parent_id').AsString;
     Namestr:=Trim(qr.FieldByName('name').AsString);
     HintStr:=Trim(qr.FieldByName('hint').AsString);
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
    end else
     qr.Next;

   end;
  finally
   qr.Free;
   tr.Free;
//   Screen.Cursor:=crDefault;
  end;
end;


procedure TfmDocTree.miNodeChangeClick(Sender: TObject);
var
  nd: TTreeNode;
begin
  nd:=tv.Selected;
  if nd=nil then exit;
  nd.EditText;
  ChangeFlag:=true;
end;

procedure TfmDocTree.TVEdited(Sender: TObject; Node: TTreeNode;
  var S: String);
var
  P: PInfoNode;
  qr: TIBQuery;
  sqls: string;
  tr: TIBTransaction;
  isChangeHint: Boolean;
begin
  if Node.Data=nil then exit;
  isChangeHint:=AnsiSameText(Node.Text,Trim(mmHint.Lines.Text));
  S:=Trim(S);
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
   tr.AddDatabase(dm.IBDbase);
   dm.IBDbase.AddTransaction(tr);
   tr.Params.Text:=DefaultTransactionParamsTwo;
   qr.Database:=dm.IBDbase;
   qr.Transaction:=tr;
   qr.Transaction.Active:=true;
   sqls:='Update '+TableTypeDoc+' set name='+QuotedStr(S)+' where typedoc_id='+inttostr(P.ID);
   qr.SQL.Add(sqls);
   qr.ExecSQL;
   P.Name:=S;
   if isChangeHint then begin
    qr.SQL.Clear;
    sqls:='Update '+TableTypeDoc+' set hint='+QuotedStr(S)+' where typedoc_id='+inttostr(P.ID);
    qr.SQL.Add(sqls);
    qr.ExecSQL;
    P.Hint:=S;
    mmHint.Lines.Text:=S;
   end; 
   qr.Transaction.CommitRetaining;
   if not isViewPath then begin
     lbTopStatus.Caption:=Format(fmtCaptionStatus,[P.Name,LV.Items.Count]);
   end else begin
     lbTopStatus.Caption:=Format(fmtCaptionStatus,[GetTreeRootFromTypeDoc(P.ID),LV.Items.Count]);
   end;

   if Assigned(fmDocReestr) then
    fmDocReestr.ActiveQuery;
  finally
   qr.Free;
   tr.Free;
   Screen.Cursor:=CrDefault;
  end;
end;

procedure TfmDocTree.miNodeDelClick(Sender: TObject);
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

procedure TfmDocTree.DeleteNode(Node: TTreeNode);
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
   tr.AddDatabase(dm.IBDbase);
   dm.IBDbase.AddTransaction(tr);
   tr.Params.Text:=DefaultTransactionParamsTwo;
   qr.Database:=dm.IBDbase;
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

procedure TfmDocTree.miNodeChangeHintClick(Sender: TObject);
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
      tr.AddDatabase(dm.IBDbase);
      dm.IBDbase.AddTransaction(tr);
      tr.Params.Text:=DefaultTransactionParamsTwo;
      qr.Database:=dm.IBDbase;
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

procedure TfmDocTree.ViewNodeNew(nd: TTreeNode; Only: Boolean);
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

procedure TfmDocTree.TVClick(Sender: TObject);
begin
   ViewNodeNew(Tv.Selected,false);
end;

procedure TfmDocTree.TVChange(Sender: TObject; Node: TTreeNode);
begin
//  ViewNodeNew(Node);
end;

procedure TfmDocTree.TVAdvancedCustomDrawItem(Sender: TCustomTreeView;
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
  end else DefaultDraw:=true;   }
end;

procedure TfmDocTree.pmLVEditPopup(Sender: TObject);
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
    miLVDocLoad.Enabled:=false;
    miLVDocSave.Enabled:=false;
    miChangeDoc.Enabled:=false;
    miLVChangeHint.Enabled:=false;
    miLVDelete.Enabled:=false;
    miLVChangeForm.Enabled:=false;
    miAddDocFromDir.Enabled:=true;
    miViewDoc.Enabled:=false;
    miLVDocTest.Enabled:=false;
    miSetNotarialAction.Enabled:=false;
    miSetNotarialActionNull.Enabled:=false;
    miSetRenovation.Enabled:=false;
    miSetRenovationNull.Enabled:=false;
    miSetSortNum.Enabled:=false;
    miSetSumm.Enabled:=false;
  end else begin
    miAddDoc.Enabled:=true;
    miAddDocFromDir.Enabled:=true;
    miChangeDoc.Enabled:=true;
    miLVChangeHint.Enabled:=true;
    miLVDelete.Enabled:=true;
    miLVDeleteAll.Enabled:=true;
    miLVChangeForm.Enabled:=true;
    miLVDocLoad.Enabled:=true;
    miLVDocSave.Enabled:=true;
    miViewDoc.Enabled:=true;
    miLVDocTest.Enabled:=true;
    miSetNotarialAction.Enabled:=true;
    miSetNotarialActionNull.Enabled:=true;
    miSetRenovation.Enabled:=true;
    miSetRenovationNull.Enabled:=true;
    miSetSortNum.Enabled:=true;
    miSetSumm.Enabled:=true;
  end;
end;

procedure TfmDocTree.miLVReportClick(Sender: TObject);
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

procedure TfmDocTree.FillListViewBase(NodeId: Integer);
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
  lv.Items.BeginUpdate;
  ms:=TMemoryStream.Create;
  try
   tr.AddDatabase(dm.IBDbase);
   dm.IBDbase.AddTransaction(tr);
   tr.Params.Text:=DefaultTransactionParamsTwo;
   qr.Database:=dm.IBDbase;
   qr.Transaction:=tr;
   qr.Transaction.Active:=true;
   sqls:='Select td.*,tna.name as tnaname,tr.name as trname from '+TableDoc+
         ' td left join '+TableNotarialAction+' tna on td.notarialaction_id=tna.notarialaction_id'+
         ' left join '+TableRenovation+' tr on td.renovation_id=tr.renovation_id'+
         ' where typedoc_id='+inttostr(NodeId)+' order by sortnum';
   qr.sql.Add(sqls);
   qr.Active:=true;
   qr.First;
   while not qr.Eof do begin
    new(PList);
    PList.Name:=Trim(qr.FieldByName('Name').AsString);
    PList.Hint:=Trim(qr.FieldByName('Hint').AsString);
    PList.ID:=qr.FieldByName('doc_id').AsInteger;
    PList.NodeID:=qr.FieldByName('typedoc_id').AsInteger;
    PList.NotarialActionID:=qr.FieldByName('notarialaction_id').AsInteger;
    PList.RenovationID:=qr.FieldByName('renovation_id').AsInteger;
    PList.SortNum:=qr.FieldByName('sortnum').AsInteger;
    PList.Summ:=qr.FieldByName('summ').AsFloat;
    li:=LV.Items.Add;
    li.Caption:=PList.Name;
    li.SubItems.Add(Trim(qr.FieldByName('tnaname').AsString));
    li.SubItems.Add(Trim(qr.FieldByName('sortnum').AsString));
    li.SubItems.Add(qr.FieldByName('trname').AsString);
    li.SubItems.Add(PList.Hint);
    li.SubItems.Add(qr.FieldByName('lastdate').AsString);
    ms.Clear;
    TBlobField(qr.fieldByName('DataDoc')).SaveToStream(ms);
    li.SubItems.Add(Format('%p',[Pointer(CalculateCheckSum(ms.Memory,ms.Size))]));
    li.SubItems.Add(qr.FieldByName('summ').AsString);
    li.data:=PList;
    qr.Next;
   end;
  finally
   ms.Free;
   qr.Free;
   tr.FRee;
   lv.Items.EndUpdate;
   Screen.Cursor:=crDefault;
  end;
end;

procedure TfmDocTree.TVKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_UP,VK_DOWN,VK_LEFT,VK_RIGHT: ViewNodeNew(Tv.Selected,false);
  end;
  OnKeyUp(Sender,Key,Shift);
end;

procedure TfmDocTree.TVKeyDown(Sender: TObject; var Key: Word;
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
    VK_F2: begin
      if ViewType=vtEdit then
        miNodeChangeClick(nil);
    end;
   end;
  end; 
 end;
 OnKeyDown(Sender,Key,Shift);
 FormKeyDown(Sender,Key,Shift);
end;

procedure TfmDocTree.miChangeDocClick(Sender: TObject);
var
  li: TListItem;
begin
  li:=Lv.Selected;
  if li=nil then exit;
  li.EditCaption;
  miChangeDoc.Checked:=true;
end;

procedure TfmDocTree.LVEdited(Sender: TObject; Item: TListItem;
  var S: String);
var
  PList: PInfoDoc;
  qr: TIBQuery;
  sqls: string;
  tr: TIBTransaction;
begin
  if ITem.Data=nil then exit;
  S:=Trim(S);
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
   tr.AddDatabase(dm.IBDbase);
   dm.IBDbase.AddTransaction(tr);
   tr.Params.Text:=DefaultTransactionParamsTwo;
   qr.Database:=dm.IBDbase;
   qr.Transaction:=tr;
   qr.Transaction.Active:=true;
   sqls:='Update '+TableDoc+' set name='+QuotedStr(S)+' where doc_id='+inttostr(PList.ID);
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

procedure TfmDocTree.miLVChangeHintClick(Sender: TObject);
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
      tr.AddDatabase(dm.IBDbase);
      dm.IBDbase.AddTransaction(tr);
      tr.Params.Text:=DefaultTransactionParamsTwo;
      qr.Database:=dm.IBDbase;
      qr.Transaction:=tr;
      qr.Transaction.Active:=true;
      sqls:='Update '+TableDoc+' set hint='''+Trim(fm.mmNint.Lines.Text)+
            ''' where doc_id='+inttostr(PList.ID);
      qr.SQL.Add(sqls);
      qr.ExecSQL;
      qr.Transaction.CommitRetaining;
      PList.Hint:=Trim(fm.mmNint.Lines.Text);
      li.SubItems.Strings[2]:=PLIst.Hint;
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

procedure TfmDocTree.miLVDeleteClick(Sender: TObject);
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

procedure TfmDocTree.DeleteSelectedInListView;
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
  tr.AddDatabase(dm.IBDbase);
  dm.IBDbase.AddTransaction(tr);
  tr.Params.Text:=DefaultTransactionParamsTwo;
  qr.Database:=dm.IBDbase;
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

procedure TfmDocTree.LVKeyDown(Sender: TObject; var Key: Word;
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
 FormKeyDown(Sender,Key,Shift);
end;

procedure TfmDocTree.miLVDeleteAllClick(Sender: TObject);
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


procedure TfmDocTree.TVMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (Shift=[ssLeft])and(tv.Selected=tv.GetNodeAt(X,Y)) then begin
    MouseLeftDown:=true;
  end else MouseLeftDown:=false;
end;

procedure TfmDocTree.TVMouseMove(Sender: TObject; Shift: TShiftState; X,
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
   end;    }
 {  if (Shift=[ssLeft])and (MouseLeftDown) then begin
    if ViewType=vtEdit then
     tv.BeginDrag(true);
   end;       }
end;

procedure TfmDocTree.TVMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button=mbLeft then begin
   MouseLeftDown:=false;
  end;
end;

procedure TfmDocTree.TVEndDrag(Sender, Target: TObject; X, Y: Integer);

   procedure UpdateSortId(ndSel: TTreeNode; ChangeParent: Boolean);
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
   end;


var
  ndCur,ndSel: TTreeNode;
begin
  if not UserIsAdmin then exit;
  ndSel:=tv.Selected;
  if ndSel=nil then exit;
  ndCur:=tv.GetNodeAt(X,Y);
  if ndCur=nil then exit;
  if ndSel=ndCur then exit;
  if (ndSel.Level=ndCur.Level)and(ndSel.Parent=ndCur.Parent)then begin
    ndSel.MoveTo(ndCur,naInsert);
    UpdateSortId(ndSel,false);
  end else begin
 {  if ndSel.Level>=ndCur.Level then begin
    ndSel.MoveTo(ndCur,naAddChild);
    UpdateSortId(ndSel,true);
   end;  }
  end;
  ChangeFlag:=true;
end;

procedure TfmDocTree.SortNodeUpdate(nd,ndParent: tTreeNode);

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
  maxi:=GetMaxidSort;
  if maxi>PInfoNode(nd.data).SortID then begin
    nd1:=GetNodeFromIdSort(PInfoNode(nd.data).SortID);
    nd.Moveto(nd1,naInsert);
  end else begin
    nd1:=Tv.Items.AddChildObject(NDParent,nd.text,nd.data);
    nd.Moveto(nd1,naInsert);
    nd1.delete;
  end;
end;

procedure TfmDocTree.TVDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
var
  ndCur,ndSel: TTreeNode;
begin
  Accept:=false;
  if not UserIsAdmin then exit;
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
  if fmDocTreeCarring<>nil then begin
   if Source=fmDocTreeCarring.lv then begin
     Accept:=true;
   end;
   if Source=fmDocTreeCarring.Tv then begin
     Accept:=true;
   end;

  end; 
end;

procedure TfmDocTree.LVMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (Shift=[ssLeft]) then begin
    MouseLeftDownLV:=true;
  end else MouseLeftDownLV:=false;
end;

procedure TfmDocTree.LVMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button=mbLeft then begin
   MouseLeftDownLV:=false;
  end;
end;

procedure TfmDocTree.LVMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  li: TListItem;
begin
   li:=lv.Selected;
   if li=nil then begin
     exit;
   end;
 {  if (Shift=[ssLeft])and (MouseLeftDownLV) then begin
     lv.BeginDrag(true);
   end;   }
end;

procedure TfmDocTree.LVEndDrag(Sender, Target: TObject; X, Y: Integer);
var
  ndCur: TTreeNode;
  pt: TPoint;
begin
  if (Target<>nil)and(Target=tv) then begin
   ndCur:=NodeCur;
   if ndCur=nil then exit;
   CopyMoveNode:=ndCur;
   GetCursorPos(pt);
   pmCopyMove.Popup(pt.X,pt.Y);
  end;
end;

procedure TfmDocTree.TVDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  nd: TTreeNode;
  P: PInfoNode;
begin
  if Source=lv then begin
    NodeCur:=TV.GetNodeAt(x,Y);
  end;
  if Source<>nil then begin
   if fmDocTreeCarring<>nil then begin
    if Source=fmDocTreeCarring.LV then begin
      nd:=TV.GetNodeAt(x,Y);
      if nd=nil then exit;
      P:=nd.Data;
      if P=nil then exit;
      fmDocTreeCarring.DragDropFromDocTreeCarListView(nd,P.ID,LV);
    end;
    if Source=fmDocTreeCarring.TV then begin
      nd:=TV.GetNodeAt(x,Y);
      fmDocTreeCarring.DragDropFromDocTreeCarTreeView(Tv,nd);
    end;
   end;
  end;
end;

procedure TfmDocTree.miAddDocClick(Sender: TObject);
var
  nd: TTreeNode;
  P: PInfoNode;
  PList: PInfoDoc;
  PlistName,PListHint: string;
  PListNodeId: Integer;
  PListId: Integer;
  li: TListITem;
  strFiles: TStringList;
  ext: string;
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
   ext:=ExtractFileExt(od.FileName);
   if trim(ext)<>'' then
    PListName:=Copy(PListName,1,AnsiPos(AnsiUpperCase(ext),AnsiUpperCase(PListName))-1);
   PlistHint:=PListName;
   PListNodeId:=P.ID;
   PListId:=GetMaxIDFromTableDoc(PListNodeId,PListName);
   new(PList);
   PList.Name:=PListName;
   PList.Hint:=PListHint;
   PList.ID:=PListId;
   PList.NodeID:=PListNodeId;
   PList.NotarialActionID:=0;
   PList.RenovationID:=GetRenovationIdByWorkDate;
   PList.Summ:=0.0;
   li:=LV.Items.Add;
   li.Caption:=PList.Name;
   li.SubItems.Add('');
   li.SubItems.Add('');
   li.SubItems.Add(GetRenovationNameById(PList.RenovationID));
   li.SubItems.Add(PListHint);
   li.SubItems.Add(DateTimeToStr(GetDateTimeFromServer));
   li.SubItems.Add(Format('%p',[Pointer(CalculateCheckSumByDocId(PList.ID))]));
   li.SubItems.Add('');

   li.Data:=PList;
   li.ImageIndex:=0;
  finally
   strFiles.Free;
  end;

end;

procedure TfmDocTree.miLVDocFileClick(Sender: TObject);
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

procedure TfmDocTree.LVDblClick(Sender: TObject);
begin
  if miChangeDoc.Checked then miChangeDoc.OnClick(nil);
  if miLVChangeHint.Checked then miLVChangeHint.OnClick(nil);
  if miLVChangeForm.Checked then miLVChangeForm.OnClick(nil);
  if miLVDocTest.Checked then miLVDocTest.OnClick(nil);
  if miViewDoc.Checked then miViewDoc.OnClick(nil);
  if miSetNotarialAction.Checked then miSetNotarialAction.OnClick(nil);
  if miSetNotarialActionNull.Checked then miSetNotarialActionNull.OnClick(nil);
  if miSetRenovation.Checked then miSetRenovation.OnClick(nil);
  if miSetRenovationNull.Checked then miSetRenovationNull.OnClick(nil);
  if miSetSortNum.Checked then miSetSortNumClick(nil);
  if miSetSumm.Checked then miSetSummClick(nil); 

end;

procedure TfmDocTree.miLVFindClick(Sender: TObject);
begin
  FindOnListView(LV);
end;

procedure TfmDocTree.LVCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);

  procedure DrawItem;
  var
    rt: Trect;
    wd: Integer;
    OldBrush: TBrush;
    OldFont: TFont;
    OldPen: Tpen;
  begin
  //drBounds, drIcon, drLabel, drSelectBounds
   OldBrush:=TBrush.Create;
   OldFont:=TFont.Create;
   OldPen:=Tpen.Create;
   try
    OldBrush.Assign(Canvas.Brush);
    OldFont.Assign(Canvas.Font);
    OldPen.Assign(Canvas.Pen);
    rt:=Item.DisplayRect(drLabel);
    with Sender.Canvas do begin
     brush.Style:=bsSolid;
     brush.Color:=clBtnFace;
     wd:=TextWidth(Item.Caption);
     InflateRect(rt,0,-1);
     rt.Right:=rt.Left+wd;
     FillRect(rt);
    end;
   finally
     Canvas.Brush.Assign(OldBrush);
     OldBrush.Free;
     Canvas.Font.Assign(OldFont);
     OldFont.Free;
     Canvas.Pen.Assign(OldPen);
     OldPen.Free;
   end;
  end;

begin
// exit;
{  DefaultDraw:=true;
  if (Item.Selected)and(not(cdsHot in State)) then
      DrawItem
  else DefaultDraw:=true;
  inherited;    }
end;

procedure TfmDocTree.LVColumnClick(Sender: TObject; Column: TListColumn);
var
 newSortItem:integer;
begin
 newSortItem:=Column.Index-1;
 if glSortSubItem=newSortItem then glSortForward:=not glSortForward
 else glSortForward:=true;
 glSortSubItem:=newSortItem;
 case Column.Index of
   0,1,3,4,5: lv.OnCompare:=lvCompareStr;
   2: lv.OnCompare:=lvCompareInt;
 end;
 lv.AlphaSort;
end;

procedure TfmDocTree.lvCompareStr(Sender: TObject; Item1, Item2: TListItem;
  Data: Integer; var Compare: Integer);
begin
 if glSortSubItem>=0 then Compare:=CompareText(Item1.SubItems[glSortSubItem],Item2.SubItems[glSortSubItem])
 else Compare:=CompareText(Item1.Caption,Item2.Caption);
 if glSortForward=false then Compare:=-Compare;
end;

procedure TfmDocTree.lvCompareInt(Sender: TObject; Item1, Item2: TListItem;
  Data: Integer; var Compare: Integer);
var
  i1,i2: Integer;  
begin
 i1:=PInfoDoc(Item1.Data).SortNum;
 i2:=PInfoDoc(Item2.Data).SortNum;
 if glSortSubItem>=0 then begin
   Compare:=i1-i2;
 end;
 if glSortForward=false then Compare:=-Compare;
end;

procedure TfmDocTree.miEditFindInTVClick(Sender: TObject);
begin
   FindOnTreeView(TV,Self);
end;

procedure TfmDocTree.miViewFindInTvClick(Sender: TObject);
begin
   FindOnTreeView(TV,Self);

end;

procedure TfmDocTree.miExpandClick(Sender: TObject);
var
  nd: TTreeNode;
begin
  nd:=tv.Selected;
  if nd=nil then exit;
  nd.Expand(true);
end;

procedure TfmDocTree.miCollapseClick(Sender: TObject);
var
  nd: TTreeNode;
begin
  nd:=tv.Selected;
  if nd=nil then exit;
  nd.Collapse(true);
end;

procedure TfmDocTree.miExpandAllClick(Sender: TObject);
begin
  TV.FullExpand;
end;

procedure TfmDocTree.miCollapseAllClick(Sender: TObject);
begin
  TV.FullCollapse;
end;

procedure TfmDocTree.miLVViewLargeIconClick(Sender: TObject);
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

{procedure TfmDocTree.SetMenuOperations(PM: TPopupMenu);
begin
end;}

procedure TfmDocTree.miLVDocTestClick(Sender: TObject);
begin
  DocTest;
  miLVDocTest.Checked:=true;
end;

function TfmDocTree.DocTest: Boolean;
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
  List:=TList.Create;
  try
    result:=false;
    if LV.SelCount<>1 then exit;
    li:=lv.Selected;
    if li=nil then exit;
    PList:=li.Data;
    fmNew:=TfmNewForm.Create(nil);
    msOutForm:=TMemoryStream.Create;
    tr:=TIBTransaction.Create(nil);
    qr:=TIBQuery.Create(nil);
    try
     Screen.Cursor:=crHourGlass;
     try
      tr.AddDatabase(dm.IBDbase);
      dm.IBDbase.AddTransaction(tr);
      tr.Params.Text:=DefaultTransactionParamsTwo;
      qr.Database:=dm.IBDbase;
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

        fmNew.LastDocId:=PList.ID;
        fmNew.RenovationID:=PList.RenovationID;
        fmNew.DestroyHeaderAndCreateNew;
        fmNew.OnKeyDown:=fmMain.OnKeyDown;
        fmNew.OnKeyPress:=fmMain.OnKeyPress;
        fmNew.OnKeyUp:=fmMain.OnKeyUp;
        fmNew.ViewType:=vtEdit;
        fmNew.ViewType:=vtView;
        fmNew.EnableOnControl(fmNew.grbDoplnit,false);


        fmNew.PrepeareControlsAfterLoad(fmNew.pnDesign);

        fmNew.FillBlanks;
        fmNew.bibOk.OnClick:=fmNew.bibOkClickTest;
        fmNew.bibCancel.OnClick:=fmNew.bibCancelClickTest;
        fmNew.bibOtlogen.OnClick:=fmNew.bibOtlogenClickTest;
        fmNew.Caption:=Trim(qr.fieldByName('name').AsString);

    //    fmNew.LocateFirstFocusedControl;
      end;

     finally
      Screen.Cursor:=crDefault;
     end;
     if not Error2 then begin
       fmNew.Hide;
       fmNew.OnShow:=fmNew.OnShowTest;
       fmNew.InitAll;
       fmNew.ShowModal;
     end;
    finally
     msOutForm.Free;
     fmNew.Free;
     qr.Free;
     tr.Free;
    end;

  finally
    ClearWordObjectList(List);
    List.Free;
  end;
end;

function TfmDocTree.GetCheckedView: Integer;
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

procedure TfmDocTree.SetCheckedView(Index: Integer);
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

function TfmDocTree.GetCheckedDocument: Integer;
{var
  i: Integer;
  mi: TmenuItem;}
begin
{  mi:=nil;
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
  end;}
  Result:=-1;
  if miViewDoc.Checked then Result:=0;
  if miLVDocTest.Checked then Result:=1;
  if miChangeDoc.Checked then Result:=2;
  if miLVChangeHint.Checked then Result:=3;
  if miLVChangeForm.Checked then Result:=4;
  if miSetNotarialAction.Checked then Result:=5;
end;

procedure TfmDocTree.SetCheckedDocument(Index: Integer);
{var
  mi: TmenuItem;}
begin
{  mi:=nil;
  case ViewType of
    vtView: mi:=miLVDocument;
    vtEdit: mi:=miLVDocument;
  end;
  if mi.Count-1>=Index then begin
    mi.Items[Index].Checked:=true;
  end;}
  case Index of
    1: miViewDoc.Checked:=true;
    2: miLVDocTest.Checked:=true;
    3: miChangeDoc.Checked:=true;
    4: miLVChangeHint.Checked:=true;
    5: miLVChangeForm.Checked:=true;
    6: miSetNotarialAction.Checked:=true;
  end;
end;

procedure TfmDocTree.miAddDocFromDirClick(Sender: TObject);
var
  Last: String;
begin
  Last:=GetDir(Application.Handle,'');
  if DirectoryExists(Last) then
   LoadDocFromDir('����������...',Last,false);
end;

procedure TfmDocTree.miAddTypeDocDirClick(Sender: TObject);
begin
  miAddDocFromDirClick(nil);
end;

procedure TfmDocTree.ExpandFirstNodes;
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

procedure TfmDocTree.LVDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  nd: TTreeNode;
  P: PInfoNode;
begin
  if Source<>nil then begin
   if fmDocTreeCarring<>nil then begin
    if Source=fmDocTreeCarring.LV then begin
      nd:=Tv.Selected;
      if nd=nil then exit;
      P:=nd.Data;
      if P=nil then exit;
      fmDocTreeCarring.DragDropFromDocTreeCarListView(nd,P.ID,LV);
    end;  
   end;  
  end;
end;

procedure TfmDocTree.LVDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  Accept:=false;
  if Sender=Source then begin
    Accept:=false;
  end;
  if fmDocTreeCarring=nil then exit;
  if Source=fmDocTreeCarring.LV then begin
    if TV.Items.Count>0 then
      Accept:=true
  end;
end;

procedure TfmDocTree.miViewDocClick(Sender: TObject);
begin
  if DocView then
    miViewDoc.Checked:=true;
end;

function TfmDocTree.DocView: Boolean;
var
  li: TListITem;
  PList: PInfoDoc;
  List: TList;
  Plus: Integer;
  IsHelper: Boolean;
begin
  result:=false;
  li:=lv.Selected;
  if li=nil then begin
    ShowError(Handle,DefSelectDocument);
    exit;
  end;
  PList:=li.Data;
  Result:=false;
  if not ExtractDocFile(PList.ID,CaptionView) then exit;
  List:=TList.Create;
  try
    Plus:=0;
    IsHelper:=false;
    if isExpandConst then
      AddDopFieldFromConst(List,Plus,IsHelper,GetRenovationIdByDocId(PList.ID));
    if SetFieldsToWord(List,true,List.Count=0) then begin
      if UserIsAdmin then begin
        ListOpenDocs.AddObject(lastFileDoc,TObject(PList.ID));
        tmViewDoc.Enabled:=true;
      end;
      result:=true;
    end;
  finally
    ClearWordObjectList(List);
    List.Free;
  end;  
end;

procedure TfmDocTree.miViewDocViewClick(Sender: TObject);
begin
  DocView;
end;

procedure TfmDocTree.bibViewClick(Sender: TObject);
begin
  miViewDocClick(nil);
end;

procedure TfmDocTree.miLVChangeFormClick(Sender: TObject);
begin
  ExtractFormOrDocFile(LV,true,'');
  miLVChangeForm.Checked:=true;
end;

procedure TfmDocTree.miLoadDirClick(Sender: TObject);
var
  Last: String;
begin
  Last:=GetDir(Application.Handle,'');
  if DirectoryExists(Last) then
   LoadDocFromDir('��������...',Last,true);
end;

procedure TfmDocTree.miLoadDocClick(Sender: TObject);
var
  PList: PInfoDoc;
  li: TListITem;
begin
  od.Filter:=FilterDoc;
  if not od.Execute then exit;
  li:=LV.Selected;
  if li=nil then exit;
  PList:=li.Data;
  if IsBadCodePtr(PList) then exit;
  LoadDocumentFromFile(od.FileName,PList.ID,LV);
end;

procedure TfmDocTree.miSaveDocClick(Sender: TObject);
var
  li: TListItem;
begin
  li:=LV.Selected;
  if li=nil then exit;
  sd.Filter:=FilterDoc;
  sd.FileName:=ExtractfileName(li.Caption)+'.doc';
  if not sd.Execute then exit;
  if not ExtractFormOrDocFile(LV,false,sd.FileName) then exit;
end;

procedure TfmDocTree.miLoadFormClick(Sender: TObject);
var
  msOutDoc: TMemoryStream;
  tb: TIBTable;
  PList: PInfoDoc;
  li: TListITem;
  tr: TIBTransaction;
  cdt: TDateTime;
begin
  od.Filter:=FilterForm;
  if not od.Execute then exit;
  li:=LV.Selected;
  if li=nil then exit;
  PList:=li.Data;
  if IsBadCodePtr(PList) then exit;
  Screen.Cursor:=crHourGlass;
  msOutDoc:=TMemoryStream.Create;
  try
   tr:=TIBTransaction.Create(nil);
   tb:=TIBTable.Create(nil);
   try
    tr.AddDatabase(dm.IBDbase);
    dm.IBDbase.AddTransaction(tr);
    tr.Params.Text:=DefaultTransactionParamsTwo;
    tb.Database:=dm.IBDbase;
    tb.Transaction:=tr;
    tb.Transaction.Active:=true;
    tb.TableName:=TableDoc;
    tb.Active:=true;
    if tb.RecordCount<>0 then begin
     msOutDoc.LoadFromFile(od.FileName);
     msOutDoc.Position:=0;
     CompressAndCrypt(msOutDoc);
     msOutDoc.Position:=0;
     tb.Locate('doc_id',Plist.ID,[loCaseInsensitive]);
     tb.Edit;
     TBlobField(tb.FieldByName('DataForm')).LoadFromStream(msOutDoc);
     tb.Post;
     tb.Transaction.CommitRetaining;
     SetCurrentDateTimeToDoc(Plist.ID,cdt);
     li.SubItems[4]:=DateTimeToStr(cdt);
    end;
   finally
    tb.Free;
   end;
  finally
   msOutDoc.free;
   Screen.Cursor:=crDefault;
  end;
end;

procedure TfmDocTree.miSaveFormClick(Sender: TObject);
var
  msIn: TmemoryStream;
  qr: TIBQuery;
  sqls: string;
  li: TListItem;
  PList: PInfoDoc;
  tr: TIBTransaction;
begin
  li:=LV.Selected;
  if li=nil then exit;
  sd.Filter:=FilterForm;
  sd.FileName:=ExtractfileName(li.Caption)+'.frm';
  if not sd.Execute then exit;
  PList:=li.data;
  if IsBadCodePtr(PList) then exit;

    Screen.Cursor:=crHourGlass;
    msIn:=TmemoryStream.Create;
    tr:=TIBTransaction.Create(nil);
    qr:=TIBQuery.Create(nil);
    try
     tr.AddDatabase(dm.IBDbase);
     dm.IBDbase.AddTransaction(tr);
     tr.Params.Text:=DefaultTransactionParamsTwo;
     qr.Database:=dm.IBDbase;
     qr.Transaction:=tr;
     qr.Transaction.Active:=true;
     sqls:='Select DataForm from '+TableDoc+' where doc_id='+inttostr(PList.ID);
     qr.SQL.Add(sqls);
     qr.Active:=true;
     TBlobField(qr.fieldByName('DataForm')).SaveToStream(msIn);
     msIn.Position:=0;
     ExtractObjectFromStream(msIn);
     msIn.Position:=0;
     msIn.SaveToFile(sd.Filename);
    finally
     qr.Free;
     tr.Free;
     msIn.Free;
     Screen.Cursor:=crdefault;
    end;
end;

procedure TfmDocTree.miSaveToDirClick(Sender: TObject);
var
  Last: String;
begin
  Last:=GetDir(Application.Handle,'');
  if DirectoryExists(Last) then
   SaveDocToDir('����������...',Last);
end;

procedure TfmDocTree.miViewSearchDocClick(Sender: TObject);
var
  nd: TTreeNode;
begin
 nd:=Tv.Selected;
 if nd=nil then exit;
 if fmSearchDoc=nil then begin
  fmSearchDoc:=TfmSearchDoc.Create(Application);
 end;
 fmSearchDoc.LoadFilter;
 fmSearchDoc.FindTypeDoc:=nd.Text;
 fmSearchDoc.ActiveQuery;
 if fmSearchDoc.FlagActive then
  fmSearchDoc.FormStyle:=fsMDIChild;
 if (fmSearchDoc<>nil)and(fmSearchDoc.FlagActive)then begin
  fmSearchDoc.BringToFront;
  fmSearchDoc.Show;
 end;
end;

procedure TfmDocTree.miMoveDocClick(Sender: TObject);


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
       li.Delete;
       dispose(PList);
     end;
    finally
     lv.Items.EndUpdate;
     List.Free;
    end;
  end;

begin
   if CopyMoveNode=nil then exit;
   UpdateLists(CopyMoveNode);
   ViewNodeNew(Tv.Selected,true);
end;

procedure TfmDocTree.miCopyDocClick(Sender: TObject);

  procedure CopyDoc(ndWhat: TTreeNode);
  var
    qrSource: TIBQuery;
    tbDest: TIBTable;
    sqls: string;
    msOut: TMemoryStream;
    tr: TIBTransaction;
    List: TList;
    i: Integer;
    li: TListItem;
    PList: PInfoDoc;
  begin
    BreakAnyProgress:=false;
    fmProgress.Caption:='�����������...';
    fmProgress.lbProgress.Caption:=ConstAddDoc;
    fmProgress.gag.Position:=0;
    fmProgress.Visible:=true;
    fmProgress.Update;

    list:=TList.Create;
    lv.Items.BeginUpdate;
    try
     GetSelectedInListView(LV,List);
     Screen.Cursor:=crHourGlass;
     msOut:=TMemoryStream.Create;
     tr:=TIBTransaction.Create(nil);
     qrSource:=TIBQuery.Create(nil);
     tbDest:=TIBTable.Create(nil);
     try
      tr.AddDatabase(dm.IBDbase);
      dm.IBDbase.AddTransaction(tr);
      tr.Params.Text:=DefaultTransactionParamsTwo;
      qrSource.Database:=dm.IBDbase;

      fmProgress.gag.Max:=List.Count;
      for i:=0 to List.Count-1 do begin
        application.ProcessMessages;
        if BreakAnyProgress then exit;

        li:=List.Items[i];
        PList:=li.Data;

        qrSource.Transaction:=tr;
        qrSource.Transaction.Active:=true;
        sqls:='Select * from '+TableDoc+' where doc_id='+inttostr(PList.ID);
        qrSource.Active:=false;
        qrSource.SQL.Clear;
        qrSource.SQL.Add(sqls);
        qrSource.Active:=true;
        if qrSource.RecordCount<>1 then exit;

        tbDest.Database:=dm.IBDbase;
        tbDest.Transaction:=tr;
        tbDest.Transaction.Active:=true;
        tbDest.Active:=false;
        tbDest.TableName:=TableDoc;
        tbDest.Filter:=' typedoc_id=0 ';
        tbDest.Filtered:=true;
        tbDest.Active:=true;

        tbDest.Append;
        tbDest.FieldByName('typedoc_id').AsInteger:=PInfoNode(ndWhat.Data).ID;
        if PList.NotarialActionID<>0 then
          tbDest.FieldByName('notarialaction_id').AsInteger:=PList.NotarialActionID;
        if PList.RenovationID<>0 then
          tbDest.FieldByName('renovation_id').AsInteger:=PList.RenovationID;


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

        SetPositonAndText(i+1,qrSource.FieldByName('name').AsString,ConstAddDoc,nil,fmProgress.gag.Max);

       end;
     finally
      msOut.Free;
      qrSource.Free;
      tbDest.Free;
      tr.FRee;
      Screen.Cursor:=crDefault;
     end;
    finally
     lv.Items.EndUpdate;
     List.Free;
     fmProgress.Visible:=false;
    end;
  end;


begin
  if CopyMoveNode=nil then exit;
  CopyDoc(CopyMoveNode);
  ViewNodeNew(Tv.Selected,true);
end;

procedure TfmDocTree.LVEnter(Sender: TObject);
begin
  if (LV.Selected=nil) and (LV.Items.Count>0) then
    LV.Selected:=LV.Items[0];
end;

procedure TfmDocTree.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_F3: begin
      bibView.Click;
    end;
  end;
end;

procedure TfmDocTree.FormResize(Sender: TObject);
begin
  StatusBar1.Top:=pnBottom.Top+pnBottom.Height+1;
end;

procedure TfmDocTree.bibViewKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  FormKeyDown(Sender,Key,Shift);
end;

procedure TfmDocTree.ColumnCountChanged;
var
  lc: TListColumn;
begin
  if isViewDateInListView then begin
   if LV.Columns.Count<7 then begin
    lc:=LV.Columns.Add;
    lc.Caption:='����������';
    lc.AutoSize:=true;
    lc.Width:=80;

    lc:=LV.Columns.Add;
    lc.Caption:='��������';
    lc.AutoSize:=true;
    lc.Width:=100;

    lc:=LV.Columns.Add;
    lc.Caption:='���� � ����� ���������';
    lc.AutoSize:=true;
    lc.Width:=80;

    lc:=LV.Columns.Add;
    lc.Caption:='����������� �����';
    lc.AutoSize:=true;
    lc.Width:=60;

    lc:=LV.Columns.Add;
    lc.Caption:='���������';
    lc.AutoSize:=true;
    lc.Width:=60;

   end;
  end else begin
    if LV.Columns.Count>7 then begin
     LV.Columns.Delete(7);
     LV.Columns.Delete(6);
     LV.Columns.Delete(5);
     LV.Columns.Delete(4);
     LV.Columns.Delete(3);
    end; 
  end;
end;

procedure TfmDocTree.tmViewDocTimer(Sender: TObject);
var
  i: Integer;
  doc_id: Integer;
  DocName: string;
  msFileName: TMemoryStream;
  CheckSumFileName: LongWord;
  CheckSumDoc: LongWord;
begin
  if isSaveDocumentOnView and not isExpandConst then begin
    tmViewDoc.Enabled:=false;
    for i:=ListOpenDocs.Count-1 downto 0 do begin
      doc_id:=Integer(ListOpenDocs.Objects[i]);
      if FileExists(ListOpenDocs.Strings[i]) then begin
       if CheckFileClosed(ListOpenDocs.Strings[i]) then begin
        DocName:=GetDocName(doc_id);
        msFileName:=TMemoryStream.Create;
        try
         CompressAndCryptFile(ListOpenDocs.Strings[i],msFileName);
         CheckSumFileName:=CalculateCheckSum(msFileName.Memory,msFileName.Size);
         CheckSumDoc:=CalculateCheckSumByDocId(doc_id);
         if CheckSumFileName<>CheckSumDoc then begin
          SetWindowPos(fmMain.Handle,HWND_TOP,0,0,0,0,SWP_NOMOVE+SWP_NOSIZE);
          SetActiveWindow(fmMain.Handle);
          BringToFront;
          if MessageDlg(Format(fmtViewDocSave,[DocName]),mtConfirmation,[mbNo,mbYes],-1)=mrYes then begin
           LoadDocumentFromFile(ListOpenDocs.Strings[i],doc_id,LV);
           ListOpenDocs.Delete(i);
          end else begin
           ListOpenDocs.Delete(i);
          end;
         end else ListOpenDocs.Delete(i);
        finally
         msFileName.Free;
        end;
       end;
      end else begin
        ListOpenDocs.Delete(i);
      end;
    end;
    if ListOpenDocs.Count>0 then
      tmViewDoc.Enabled:=true;
  end;    
end;

procedure TfmDocTree.miSetNotarialActionClick(Sender: TObject);
var
  fm: TfmRBNotarialAction;
  na_id,i: Integer;
  li: TListItem;
  P,PCur: PInfoDoc;
begin
  li:=lv.Selected;
  if li=nil then exit;
  P:=li.data;
  if P=nil then exit;
  miSetNotarialAction.Checked:=true;
  fm:=TfmRBNotarialAction.Create(nil);
  try
    na_id:=GetNotarialActionIdByDocId(P.ID);
    if na_id=0 then
      ShowInfo('��� �������� � ������������� ��������.');
    fm.BorderIcons:=fm.BorderIcons-[biMinimize];
    fm.bibOk.Visible:=true;
    fm.bibOk.OnClick:=fm.MR;
    fm.Grid.OnDblClick:=fm.MR;
    fm.ActiveQuery;
    if na_id<>0 then
      fm.Mainqr.Locate('notarialaction_id',na_id,[loCaseInsensitive]);
    if fm.ShowModal=mrOk then begin
      if not fm.Mainqr.IsEmpty then begin

        for i:=0 to LV.Items.Count-1 do begin
          li:=LV.Items[i];
          if li.Selected then begin
            PCur:=li.data;
            if PCur<>nil then begin
              SetNotarialActionIdByDocId(fm.Mainqr.FieldByName('notarialaction_id').AsInteger,
                                         PCur.ID,
                                         fm.Mainqr.FieldByName('name').AsString);
              PCur.NotarialActionID:=fm.Mainqr.FieldByName('notarialaction_id').AsInteger;
              li.SubItems[0]:=fm.Mainqr.FieldByName('name').AsString;
            end;  
          end;
        end;
      end;
    end;
  finally
    fm.Free;
  end;
end;

function TfmDocTree.GetNodeByTypeDocId(TypeDocId: Integer): TTreeNode;
var
  i: Integer;
  PNode: PInfoNode;
begin
  Result:=nil;
  for i:=0 to TV.Items.Count-1 do begin
    PNode:=Tv.Items[i].Data;
    if PNode<>nil then begin
      if PNode.ID=TypeDocId then begin
        Result:=Tv.Items[i];
        exit;
      end;
    end;
  end;
end;

function TfmDocTree.GetListItemByDocId(DocId: Integer): TListItem;
var
  i: Integer;
  PList: PInfoDoc;
begin
  Result:=nil;
  for i:=0 to Lv.Items.Count-1 do begin
    PList:=Lv.Items[i].Data;
    if PList<>nil then begin
      if PList.ID=DocId then begin
        Result:=Lv.Items[i];
        exit;
      end;
    end;
  end;
end;

procedure UnselectListView(LV: TListView);
var
  i: Integer;
begin
  Lv.Items.BeginUpdate;
  try
    for i:=0 to Lv.Items.Count-1 do begin
      Lv.Items[i].Selected:=false;
    end;
  finally
   Lv.Items.EndUpdate;
  end;  
end;

function TfmDocTree.ViewDoc(TypeDocId, DocId: Integer): Boolean;
var
  nd: TTreeNode;
  li: TListItem;
begin
  Result:=false;
  nd:=GetNodeByTypeDocId(TypeDocId);
  if nd=nil then exit;
  nd.Selected:=true;
  nd.MakeVisible;
  ViewNodeNew(nd,false);
  li:=GetListItemByDocId(DocId);
  if li=nil then exit;
  ShowWindow(Handle,SW_RESTORE);
  Show;
  BringToFront;
  LV.SetFocus;
  UnselectListView(LV);
  li.Selected:=true;
  li.MakeVisible(true);
  Result:=true;
end;


procedure TfmDocTree.miSetRenovationClick(Sender: TObject);
var
  fm: TfmRenovation;
  r_id,i: Integer;
  li: TListItem;
  P,PCur: PInfoDoc;
begin
  li:=lv.Selected;
  if li=nil then exit;
  P:=li.data;
  if P=nil then exit;
  miSetRenovation.Checked:=true;
  fm:=TfmRenovation.Create(nil);
  try
    r_id:=GetRenovationIdByDocId(P.ID);
    if r_id=0 then
      ShowInfo('��� �������� � ����������.');
    fm.BorderIcons:=fm.BorderIcons-[biMinimize];
    fm.bibOk.Visible:=true;
    fm.bibOk.OnClick:=fm.MR;
    fm.Grid.OnDblClick:=fm.MR;
    fm.ActiveQuery;
    if r_id<>0 then
      fm.Mainqr.Locate('renovation_id',r_id,[loCaseInsensitive]);
    if fm.ShowModal=mrOk then begin
      if not fm.Mainqr.IsEmpty then begin

        for i:=0 to LV.Items.Count-1 do begin
          li:=LV.Items[i];
          if li.Selected then begin
            PCur:=li.data;
            if PCur<>nil then begin
              SetRenovationIdByDocId(fm.Mainqr.FieldByName('renovation_id').AsInteger,PCur.ID);
              PCur.RenovationID:=fm.Mainqr.FieldByName('renovation_id').AsInteger;
              li.SubItems[2]:=fm.Mainqr.FieldByName('name').AsString;
            end;
          end;
        end;
      end;
    end;
  finally
    fm.Free;
  end;
end;

procedure TfmDocTree.miSetRenovationNullClick(Sender: TObject);
var
  li: TListItem;
  i: Integer;
  PCur: PInfoDoc;
begin
  miSetRenovationNull.Checked:=true;
  for i:=0 to LV.Items.Count-1 do begin
    li:=LV.Items[i];
    if li.Selected then begin
      PCur:=li.data;
      if PCur<>nil then begin
        SetRenovationIdByDocId(0,PCur.ID);
        PCur.RenovationID:=0;
        li.SubItems[2]:='';
      end;
    end;
  end;
end;

procedure TfmDocTree.miSetNotarialActionNullClick(Sender: TObject);
var
  li: TListItem;
  i: Integer;
  PCur: PInfoDoc;
begin
  miSetNotarialActionNull.Checked:=true;
  for i:=0 to LV.Items.Count-1 do begin
    li:=LV.Items[i];
    if li.Selected then begin
      PCur:=li.data;
      if PCur<>nil then begin
        SetNotarialActionIdByDocId(0,PCur.ID,'');
        PCur.NotarialActionID:=0;
        li.SubItems[0]:='';
      end;
    end;
  end;
end;

procedure TfmDocTree.miSetSortNumClick(Sender: TObject);
var
  fm: TfmInputSortNum;
  li: TListItem;
  PCur: PInfoDoc;
begin
  li:=Lv.Selected;
  if not Assigned(li) then exit;
  PCur:=li.data;
  if Assigned(PCur) then begin
    fm:=TfmInputSortNum.Create(nil);
    try
      fm.Caption:='���������� �������';
      fm.lbNumber.Caption:='������� �������:';
      fm.edNumber.OnKeyPress:=fm.edNumberKeyPressInteger;
      fm.edNumber.Text:=li.SubItems[1];
      if (fm.ShowModal=mrOk) then begin
        if Trim(fm.edNumber.Text)<>'' then
          PCur.SortNum:=StrToInt(fm.edNumber.Text)
        else
          PCur.SortNum:=-1;
        SetDocSortNum(PCur.ID,PCur.SortNum);
        li.SubItems[1]:=fm.edNumber.Text;
      end;
      miSetSortNum.Checked:=true;
    finally
      fm.Free;
    end;
  end;
end;

procedure TfmDocTree.miSetSummClick(Sender: TObject);
var
  fm: TfmInputSortNum;
  li: TListItem;
  PCur: PInfoDoc;
begin
  li:=Lv.Selected;
  if not Assigned(li) then exit;
  PCur:=li.data;
  if Assigned(PCur) then begin
    fm:=TfmInputSortNum.Create(nil);
    try
      fm.Caption:='���������� �����';
      fm.lbNumber.Caption:='����� �������:';
      fm.edNumber.OnKeyPress:=fm.edNumberKeyPressFloat;
      fm.edNumber.Text:=iff(PCur.Summ>0.0,FloatToSTr(PCur.Summ),'');
      if (fm.ShowModal=mrOk) then begin
        if Trim(fm.edNumber.Text)<>'' then
          PCur.Summ:=StrToFloat(fm.edNumber.Text)
        else
          PCur.Summ:=-1.0;
        SetDocSumm(PCur.ID,PCur.Summ);
        li.SubItems[6]:=fm.edNumber.Text;
      end;
      miSetSumm.Checked:=true;
    finally
      fm.Free;
    end;
  end;
end;

end.