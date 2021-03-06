unit UMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Menus, ComCtrls, contnrs, ImgList, UDm, UParentForm, ToolWin,
  ExtCtrls, DsnUnit, Mask, Tabnotbk, inifiles, Buttons, IBQuery, IBDatabase,
  XPMan, jpeg, ShellApi;

type

  TfmMain = class(TForm)
    stbStatus: TStatusBar;
    ilMM: TImageList;
    mm: TMainMenu;
    sd: TSaveDialog;
    od: TOpenDialog;
    tmBackUp: TTimer;
    miFileNew: TMenuItem;
    miExitNew: TMenuItem;
    mihelpNew: TMenuItem;
    miRB: TMenuItem;
    miRBUsers: TMenuItem;
    miHelpAboutNew: TMenuItem;
    miViewNew: TMenuItem;
    miViewViewNew: TMenuItem;
    miViewEditNew: TMenuItem;
    miWindowNew: TMenuItem;
    miWindowCascadeNew: TMenuItem;
    miWindowVertNew: TMenuItem;
    miWindowGorizNew: TMenuItem;
    miWindowMinAllNew: TMenuItem;
    miWindowResAllNew: TMenuItem;
    miRBTypeReestr: TMenuItem;
    miRBOperation: TMenuItem;
    miRBMask: TMenuItem;
    miRBCase: TMenuItem;
    pmCtrlEdit: TPopupMenu;
    miCtrlPorydok: TMenuItem;
    miBringToFront: TMenuItem;
    miSendToBack: TMenuItem;
    miCtrlTabOrder: TMenuItem;
    miCtrlAlign: TMenuItem;
    N1: TMenuItem;
    miCtrlCreate: TMenuItem;
    N3: TMenuItem;
    miCtrlCut: TMenuItem;
    miCtrlCopy: TMenuItem;
    miInsertCtrl: TMenuItem;
    miDelCtrl: TMenuItem;
    miSelAllCtrl: TMenuItem;
    MenuItem1: TMenuItem;
    miPropCtrl: TMenuItem;
    miNewTab: TMenuItem;
    N2: TMenuItem;
    miRefreshAll: TMenuItem;
    N4: TMenuItem;
    miLoginNew: TMenuItem;
    miService: TMenuItem;
    miOptions: TMenuItem;
    miArchive: TMenuItem;
    N5: TMenuItem;
    miSaveArch: TMenuItem;
    miLoadArch: TMenuItem;
    miInstrHelp: TMenuItem;
    N6: TMenuItem;
    miRBMarkCar: TMenuItem;
    miRBColor: TMenuItem;
    miRBLicense: TMenuItem;
    miRBNotarius: TMenuItem;
    miSearch: TMenuItem;
    miSearchInReestr: TMenuItem;
    ctrlBarTop: TControlBar;
    tlbMain: TToolBar;
    tlbRefreshAll: TToolButton;
    tlbSearhInReestr: TToolButton;
    N7: TMenuItem;
    miPanelBut: TMenuItem;
    miReports: TMenuItem;
    miSuperReport: TMenuItem;
    miSearchNumInreestr: TMenuItem;
    miOperations: TMenuItem;
    miChangeWorkYear: TMenuItem;
    miCarringDoc: TMenuItem;
    spbWorkYear: TSpeedButton;
    miSearchDoc: TMenuItem;
    miRBConst: TMenuItem;
    pnHelper: TPanel;
    lbHelper: TLabel;
    cmbHelper: TComboBox;
    miCurrentForm: TMenuItem;
    miRBNotarialAction: TMenuItem;
    miStatisticReport: TMenuItem;
    miRBHereditarydeal: TMenuItem;
    miRBSubs: TMenuItem;
    miRBSubsValue: TMenuItem;
    N8: TMenuItem;
    miOperationPatchUtil: TMenuItem;
    miCtrlBuild: TMenuItem;
    miRuleForElement: TMenuItem;
    tlbutReestr: TToolButton;
    tlbbutDocTree: TToolButton;
    miCtrlAddToRule: TMenuItem;
    N10: TMenuItem;
    tlbbutHereditaryDeal: TToolButton;
    miUpdateInfo: TMenuItem;
    miRbReminder: TMenuItem;
    miRbRenovation: TMenuItem;
    miOperationUpdateWords: TMenuItem;
    tlbGraphVisit: TToolButton;
    miGraphVisit: TMenuItem;
    tlbOptions: TToolButton;
    miDeleteDocLocks: TMenuItem;
    miListHereditaryDeal: TMenuItem;
    miChamber: TMenuItem;
    miNotary: TMenuItem;
    tlbNotary: TToolButton;
    miSelectDatabase: TMenuItem;
    N11: TMenuItem;
    XPManifest1: TXPManifest;
    N9: TMenuItem;
    miScript: TMenuItem;
    TimerCheck: TTimer;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    MenuItemReceptionNotary: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    PanelLogo: TPanel;
    ImageLogo: TImage;
    miRBBlanks: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure miExitNewClick(Sender: TObject);
    procedure miWindowsCascadeClick(Sender: TObject);
    procedure miWindowsHorizontClick(Sender: TObject);
    procedure miWindowsVerticalClick(Sender: TObject);
    procedure miWindowsMinimizeAllClick(Sender: TObject);
    procedure miWindowsRestoreAllClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure stbStatusDrawPanel(StatusBar: TStatusBar;
      Panel: TStatusPanel; const Rect: TRect);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure miViewViewClick(Sender: TObject);
    procedure miOperationsClick(Sender: TObject);
    procedure miFileExitClick(Sender: TObject);
    procedure N11AdvancedDrawItem(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; State: TOwnerDrawState);
    procedure N11DrawItem(Sender: TObject; ACanvas: TCanvas; ARect: TRect;
      Selected: Boolean);
    procedure miHelpAboutClick(Sender: TObject);
    procedure miServicePackClick(Sender: TObject);
    procedure miArchiveSaveClick(Sender: TObject);
    procedure miArchiveLoadClick(Sender: TObject);
    procedure miRBooksUsersClick(Sender: TObject);
    procedure miOptionsClick(Sender: TObject);
    procedure tmBackUpTimer(Sender: TObject);
    procedure miViewViewNewClick(Sender: TObject);
    procedure miWindowCascadeNewClick(Sender: TObject);
    procedure miWindowVertNewClick(Sender: TObject);
    procedure miWindowGorizNewClick(Sender: TObject);
    procedure miWindowMinAllNewClick(Sender: TObject);
    procedure miWindowResAllNewClick(Sender: TObject);
    procedure miRBTypeReestrClick(Sender: TObject);
    procedure tlbRBTypeReestrClick(Sender: TObject);
    procedure tlbRBOperationsClick(Sender: TObject);
    procedure miRBOperationClick(Sender: TObject);
    procedure miRBMaskClick(Sender: TObject);
    procedure tlbRBMaskClick(Sender: TObject);
    procedure miRBCaseClick(Sender: TObject);
    procedure tlbRbCaseClick(Sender: TObject);
    procedure miRefreshAllClick(Sender: TObject);
    procedure miLoginNewClick(Sender: TObject);
    procedure tlbRefreshAllClick(Sender: TObject);
    procedure tlbOptionsClick(Sender: TObject);
    procedure miSaveArchClick(Sender: TObject);
    procedure miLoadArchClick(Sender: TObject);
    procedure miInstrHelpClick(Sender: TObject);
    procedure miRBMarkCarClick(Sender: TObject);
    procedure tlbRBMarkCarClick(Sender: TObject);
    procedure miRBColorClick(Sender: TObject);
    procedure tlbRBColorClick(Sender: TObject);
    procedure miRBLicenseClick(Sender: TObject);
    procedure tlbRBLicenseClick(Sender: TObject);
    procedure miRBNotariusClick(Sender: TObject);
    procedure tlbRBNotariusClick(Sender: TObject);
    procedure miSearchInReestrClick(Sender: TObject);
    procedure tlbSearhInReestrClick(Sender: TObject);
    procedure miPanelButClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure miSuperReportClick(Sender: TObject);
    procedure miSearchNumInreestrClick(Sender: TObject);
    procedure spbWorkYearClick(Sender: TObject);
    procedure miChangeWorkYearClick(Sender: TObject);
    procedure miCarringDocClick(Sender: TObject);
    procedure miSearchDocClick(Sender: TObject);
    procedure miRBConstClick(Sender: TObject);
    procedure cmbHelperChange(Sender: TObject);
    procedure tlbCurrentFormClick(Sender: TObject);
    procedure miCurrentFormClick(Sender: TObject);
    procedure miRBNotarialActionClick(Sender: TObject);
    procedure miStatisticReportClick(Sender: TObject);
    procedure miRBHereditarydealClick(Sender: TObject);
    procedure miRBSubsClick(Sender: TObject);
    procedure miRBSubsValueClick(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure miOperationPatchUtilClick(Sender: TObject);
    procedure miRuleForElementClick(Sender: TObject);
    procedure tlbutReestrClick(Sender: TObject);
    procedure tlbbutDocTreeClick(Sender: TObject);
    procedure tlbbutHereditaryDealClick(Sender: TObject);
    procedure miUpdateInfoClick(Sender: TObject);
    procedure miRbReminderClick(Sender: TObject);
    procedure miRbRenovationClick(Sender: TObject);
    procedure miOperationUpdateWordsClick(Sender: TObject);
    procedure miGraphVisitClick(Sender: TObject);
    procedure tlbGraphVisitClick(Sender: TObject);
    procedure miDeleteDocLocksClick(Sender: TObject);
    procedure miListHereditaryDealClick(Sender: TObject);
    procedure miChamberClick(Sender: TObject);
    procedure miNotaryClick(Sender: TObject);
    procedure tlbNotaryClick(Sender: TObject);
    procedure miSelectDatabaseClick(Sender: TObject);
    procedure TimerCheckTimer(Sender: TObject);
    procedure MenuItemReceptionNotaryClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure ImageLogoClick(Sender: TObject);
    procedure miRBBlanksClick(Sender: TObject);
  private
    FOldHintWindowClass: THintWindowClass; 
    tmCheck: TTimer;
    procedure AppOnHint(Sender: TObject);
    procedure AppOnMess(var Msg: TMsg; var Handled: Boolean);
    procedure AppOnIdle(Sender: TObject; var Done: Boolean);
    procedure tmCheckOnTimer(Sender: TObject);
    procedure CNKeyDown(var Message: TWMKeyDown); message CN_KEYDOWN;
    procedure CNKeyUp(var Message: TWMKeyUp); message CN_KEYUP;
    procedure SetLogoPosition(Visible: Boolean);
  public
    ViewType: TViewType;
    procedure WMMenuSelect(var Message: TWMMenuSelect);message WM_MENUSELECT;
    procedure MinimizeOrRestore(Minimize: Boolean);
    procedure PanelRedraw;
    procedure SetViewTypeForAllForms;
    procedure SetViewType(Value: TViewType);
    procedure ClickMDIMenu(Sender: TObject);
    procedure FillHelpers;
    procedure RefreshNeeded;
    procedure ViewWhoCert;
    procedure SelectNotariusById(NotariusId: Integer);
  end;

var
  fmMain: TfmMain;

implementation

uses BisHintEx,
  UDocTree,UNewForm, UDocReestr, Mcompres, UAbout, URBUsers, ULogin,
  UOptions, URBTypeReestr, URBOperation, URBMask, URBCase,
  URBMarkCar, URBColor, URBLicense, URBNotarius, USearchReestr,
  USuperReport, USearchNumInReestr, UDocTreeCarring, USearchDoc, URBConst,
  URBNotarialAction, UStatisticReport, URBHereditaryDeal, URBSubs,
  URBSubsValue, URBPeople, UPatchUtil, URBRuleForElement, UUpdateInfo,
  UNewControls, URBReminder, URBRenovation, URBGraphVisit, USelectNotarius,
  UListHereditaryDealReport, SeoDbConsts, URBChamber, URBNotary, URBBlanks,
  ReceptionFm,
  SeoPicture;

{$R *.DFM}
{$R checkpoint.res}


procedure TfmMain.SetViewType(Value: TViewType);
begin
  ViewType:=Value;
  case Value of
    vtView: stbStatus.Panels.Items[1].Text:=StatusView;
    vtEdit: stbStatus.Panels.Items[1].Text:=StatusEdit;
  end;
end;

procedure TfmMain.FormCreate(Sender: TObject);
var
  Buffer: string;
  ms: TMemoryStream;
begin
  Buffer:='';
  if LocalDb.ReadParam(SDb_ParamProgramm,Buffer) then
    Caption:=Format(SMainCaption,[Buffer])+' - '+UserName;

  FormGridSize:=8;
  TempDocFilePath:=ExtractFileDir(Application.Exename)+'\'+DefTempDocDir;

  FOldHintWindowClass:=HintWindowClass;
  HintWindowClass:=TBisHintWindowEx;
  Application.ShowHint:=false;
  Application.ShowHint:=true;
  Application.OnHint:=AppOnHint;
  Application.OnMessage:=AppOnMess;
  Application.OnIdle:=AppOnIdle;
  ListClasses:=TList.Create;
  InitClasses;
  ListClassesForWord:=TList.Create;
  InitClassesForWord;
  ListDefaultConst:=TStringList.Create;
  InitDefaultConst;
  ListFieldNoCreate:=TStringList.Create;
  InitFieldNoCreate;
  ListReestrForms:=TList.Create;
  ListDefaultStyles:=TStringList.Create;
  AddDefaultStyles;
  ListMenuItems:=TList.Create;
  stbStatus.Panels.Items[3].Width:=300;
  stbStatus.Panels.Items[4].Style:=psOwnerDraw;
  stbStatus.Panels.Items[5].Style:=psOwnerDraw;
  stbStatus.Panels.Items[6].Style:=psOwnerDraw;
  stbStatus.Panels.Items[7].Style:=psOwnerDraw;
  SetViewType(vtEdit);
  tmBackUp.Interval:=BackUpTime*60*1000;
  tmBackUp.Enabled:=isBackUpTime;
  tmCheck:=TTimer.Create(nil);
  tmCheck.Interval:=GetRndTime;
  tmCheck.Enabled:=true;
  tmCheck.OnTimer:=tmCheckOnTimer;

  spbWorkYear.Caption:=Format(ConstWorkDate,[FormatDateTime(fmtDate,WorkDate)]);

  TControl(spbWorkYear).Align:=alClient;
  ReadAndSettlbMainParams;

  FillHelpers;

  ms:=TMemoryStream.Create;
  try
    if LocalDb.ReadParam(SDb_ParamLogo,Buffer) then begin
      ms.Write(Pointer(Buffer)^,Length(Buffer));
      ms.Position:=0;
      TSeoPicture(ImageLogo.Picture).LoadFromStream(ms);
    end;
  finally
    ms.Free;
  end;

  ImageLogo.Align:=alClient;
  Windows.SetParent(PanelLogo.Handle,ClientHandle);
  SetLogoPosition(false);

  TimerCheck.Interval:=1000*60*Random(10);
  TimerCheck.Enabled:=true;
end;

procedure TfmMain.RefreshNeeded;
begin
  FillHelpers;
end;

procedure TfmMain.FillHelpers;
var
  qr: TIBQuery;
  sqls: string;
  tr: TIBTransaction;
  Obj: TInfoHelperItem;
begin
  tr:=TIBTransaction.Create(nil);
  qr:=TIBQuery.Create(nil);
  try
   try
    ClearStrings(cmbHelper.Items);
    tr.AddDatabase(dm.IBDbase);
    dm.IBDbase.AddTransaction(tr);
    tr.Params.Text:=DefaultTransactionParamsTwo;
    qr.Database:=dm.IBDbase;
    qr.Transaction:=tr;
    qr.Transaction.Active:=true;
    sqls:='Select * from '+TableNotarius+' order by fio';
    qr.sql.Add(sqls);
    qr.Active:=true;
    qr.First;
    while not qr.Eof do begin
      Obj:=TInfoHelperItem.Create;
      Obj.NotId:=qr.FieldByname('not_id').AsInteger;
      Obj.isHelper:=qr.FieldByname('ishelper').AsInteger;
      cmbHelper.Items.AddObject(GetSmallFIONEw(qr.FieldByname('fio').AsString),Obj);
      qr.Next;
    end;
   except
   end;
  finally
   if cmbHelper.Items.Count>0 then
     cmbHelper.ItemIndex:=0;
   if (LastHelperIndex>=0) or (LastHelperIndex<=cmbHelper.Items.Count-1) then
     cmbHelper.ItemIndex:=LastHelperIndex;
   qr.Free;
   tr.Free;
  end;
end;

procedure TfmMain.FormClose(Sender: TObject; var Action: TCloseAction);
var
  NewFormClosed: Boolean;
  Ret: Integer;
  FlagBackUp: Boolean;
begin
  FlagBackUp:=false;
  if isBackUpLast then begin
    if isQuestionBackup then begin
      Ret:=MessageDlg('������� ����� ���� ������?',mtConfirmation,[mbYes,mbNo,mbCancel],-1);
      case Ret of
        mrYes: begin
          FlagBackUp:=true;
          Action:=caFree;
        end;
        mrNo: begin
          Action:=caFree;
        end;
        mrCancel: begin
          Action:=caNone;
          exit;
        end;
      end;
    end else
      FlagBackUp:=true;
  end;

  if NewForm<>nil then begin

    NewFormClosed:=NewForm.CloseQuery;
    if not NewFormClosed then begin
      Action:=caNone;
      miCurrentFormClick(nil);
      exit;
    end;
  end;
  LastHelperIndex:=cmbHelper.ItemIndex;
  tmCheck.Free;
  SaveToIni;
  DestroyClassesForWord;
  ListClassesForWord.Free;
  ListDefaultConst.Free;
  ListFieldNoCreate.Free;
  DestroyClasses;
  ListClasses.Free;
  ClearReestrForms;
  ListReestrForms.Free;
  ClearListMenuItems;
  ListMenuItems.Free;
  ListDefaultStyles.Free;

  if not isAutoBuildWords then
    UpdateWordsInReestrByToday;

  if isCloseWord then
   CloseWord;
  if FlagBackUp then begin
    CreateBackUp('');
  end;
  DeleteBackUp;
  if isClearTempDir then ClearTempDir;

  ClearStrings(cmbHelper.Items);  
  HintWindowClass:=FOldHintWindowClass;
end;

procedure TfmMain.AppOnHint(Sender: TObject);
begin
 // CancelHintEx;
  stbStatus.Panels.Items[3].Text:=Application.Hint;
end;

procedure TfmMain.AppOnIdle(Sender: TObject; var Done: Boolean);
begin
end;

procedure TfmMain.miExitNewClick(Sender: TObject);
begin
  Close;
end;

procedure TfmMain.miWindowsCascadeClick(Sender: TObject);
begin
  //
end;

procedure TfmMain.miWindowsHorizontClick(Sender: TObject);
begin
//
end;

procedure TfmMain.miWindowsVerticalClick(Sender: TObject);
begin
//
end;

procedure TfmMain.miWindowsMinimizeAllClick(Sender: TObject);
begin
//
end;

procedure TfmMain.miWindowsRestoreAllClick(Sender: TObject);
begin
//
end;

procedure TfmMain.MinimizeOrRestore(Minimize: Boolean);
var
  i: Integer;
  fm: TForm;
  Flag: LongWord;
  List: Tlist;
begin
  if Minimize then
    Flag:=SW_MINIMIZE
  else Flag:=SW_RESTORE;

  List:=TList.Create;
  try
   for i:=0 to MDIChildCount-1 do begin
    fm:=MDIChildren[i];
    list.Add(fm);
   end;
   for i:=0 to List.Count-1 do begin
    fm:=List.Items[i];
    ShowWindow(fm.Handle,Flag);
   end;
   
  finally
   List.Free;
  end; 

end;


procedure TfmMain.stbStatusDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);

  procedure DrawKeyBoardState;
  var
    tmps: string;
    x: Integer;
    y: Integer;
  const
    KeyStateStr: array[0..3] of string=('NUM','CAPS','SCROLL','INSERT');
    ColorEnabled=clWindowText;
    ColorDisable=clGrayText;
  begin
    with StatusBar.Canvas do begin
      Font.Color:=ColorDisable;
      tmps:=KeyStateStr[Panel.Index-4];
      x:=Rect.Left+(Rect.Right-Rect.Left)div 2-TextWidth(tmps) div 2;
      y:=Rect.Top+(Rect.Bottom-Rect.Top)div 2-TextHeight(tmps)div 2-1;
      if (GetKeyState(VK_NUMLOCK)=1) and(Panel.Index=4) then begin
       Font.Color:=ColorEnabled;
      end;
      if (GetKeyState(VK_CAPITAL)=1) and(Panel.Index=5) then begin
       Font.Color:=ColorEnabled;
      end;
      if (GetKeyState(VK_SCROLL)=1) and(Panel.Index=6) then begin
       Font.Color:=ColorEnabled;
      end;
      if (GetKeyState(VK_INSERT)=1) and(Panel.Index=7) then begin
       Font.Color:=ColorEnabled;
      end;
      FillRect(Rect);
      TextRect(Rect,x,y,tmps);
    end;
  end;


begin
  if Panel.Index in [4..7] then begin
    DrawKeyBoardState;
  end;
end;

procedure TfmMain.TimerCheckTimer(Sender: TObject);
var
  mr: TModalResult;
begin
  TimerCheck.Enabled:=false;
  try
    TimerCheck.Interval:=1000*60*Random(10);
    if CheckDemo then begin
      mr:=MessageDlg('�� �������� ������������ ���������� ����������� ���������������� ������, ������� ���������?',mtWarning,[mbYes,mbNo],-1);
      if mr=mrYes then
        Close;
    end;
  finally
    TimerCheck.Enabled:=true;
  end;
end;

procedure TfmMain.PanelRedraw;
begin
end;

procedure TfmMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_NUMLOCK,VK_CAPITAL,VK_SCROLL,VK_INSERT: begin
     stbStatus.Invalidate;
    end;
    VK_F10: begin
     if not (ssShift in Shift) then 
    end;
  end;
{  if Shift=[ssAlt] then begin
    tlbMain.TrackMenu(tbFile);
  end;}
end;

procedure TfmMain.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_NUMLOCK,VK_CAPITAL,VK_SCROLL,VK_INSERT: begin
     stbStatus.Invalidate;
    end;
  end;
end;

procedure TfmMain.FormActivate(Sender: TObject);
begin
  stbStatus.Invalidate;
end;

procedure TfmMain.miViewViewClick(Sender: TObject);
begin
//
end;

procedure TfmMain.SetViewTypeForAllForms;
{var
  i: Integer;
/  fm: TfmNewForm;}
begin

  fmDocTree.ViewType:=ViewType;

{  for i:=0 to ListForms.Count-1 do begin
    fm:=ListForms.Items[i];
    fm.ViewType:=ViewType;
  end;}
end;

procedure TfmMain.miOperationsClick(Sender: TObject);
begin
  exit;

end;

procedure TfmMain.WMMenuSelect(var Message: TWMMenuSelect);
begin
 Inherited;
end;

procedure TfmMain.miFileExitClick(Sender: TObject);
begin
  Close;
end;

type
  TNewCtrl=class(TWinControl)
   public
     property PopupMenu;
  end;

procedure TfmMain.ClickMDIMenu(Sender: TObject);
var
  i: Integer;
  P: PInfoMenu;
begin
  for i:=0 to ListMenuItems.Count-1 do begin
    P:=ListMenuItems.Items[i];
    if P.mi=Sender then begin
      P.fm.BringToFront;
      P.mi.Checked:=true;
    end;
  end;
end;

procedure TfmMain.N11AdvancedDrawItem(Sender: TObject; ACanvas: TCanvas;
  ARect: TRect; State: TOwnerDrawState);
begin
  ACanvas.brush.Style:=bsSolid;
  ACanvas.brush.Color:=clBlack;
  ACanvas.Fillrect(ARect);
end;

procedure TfmMain.N11DrawItem(Sender: TObject; ACanvas: TCanvas;
  ARect: TRect; Selected: Boolean);
begin
  ACanvas.brush.Style:=bsSolid;
  ACanvas.brush.Color:=clBlack;
  ACanvas.Fillrect(ARect);
end;

procedure TfmMain.miHelpAboutClick(Sender: TObject);
var
  fm: TfmAbout;
begin
  fm:=TfmAbout.Create(nil);
  try
   fm.ShowModal;
  finally
   fm.Free;
  end;
end;

procedure TfmMain.miServicePackClick(Sender: TObject);
begin
   PackTables(handle,true);
end;

procedure TfmMain.miArchiveSaveClick(Sender: TObject);
begin
{  if not sd.Execute then exit;
  Screen.Cursor:=crHourGlass;
  try

   CompressDir(DataFolder,sd.FileName);
  finally
    Screen.Cursor:=crDefault;
  end;}
end;

procedure TfmMain.miArchiveLoadClick(Sender: TObject);
begin
{  if not od.Execute then exit;
  Screen.Cursor:=crHourGlass;
  try
   ArchiveToDir(DataFolder,od.FileName);
   RefreshAll;
  finally
    Screen.Cursor:=crDefault;
  end;}
end;

procedure TfmMain.miRBooksUsersClick(Sender: TObject);
begin
 if fmUsers=nil then begin
  fmUsers:=TfmUsers.Create(Application);
  fmUsers.LoadFilter;
  fmUsers.ActiveQuery;
  fmUsers.bibOk.Visible:=false;
  fmUsers.FormStyle:=fsMDIChild;
 end;
 if fmUsers<>nil then begin
  fmUsers.BringToFront;
  fmUsers.Show;
 end;
end;


procedure TfmMain.miOptionsClick(Sender: TObject);
var
  fm: TfmOptions;
begin
  fm:=TfmOptions.Create(nil);
  try
   fm.isSetAll:=false;

   fm.LoadDatabases;
   
   fm.chbFirstArch.Checked:=isBackUpFirst;
   fm.chbLastArch.Checked:=isBackUpLast;
   fm.chbTimeArch.Checked:=isBackUpTime;
   fm.udTimeArch.Position:=BackUpTime;
   fm.udFreezeArch.Position:=BackUpFreeze;
   fm.udRestoreSleep.Position:=RestoreSleep;
   fm.chbDelTempFile.Checked:=isClearTempDir;
   fm.edFileHelp.Text:=FileHelp;
   fm.chbTextPClose.Checked:=isCloseWord;
   fm.hkTranslateToUpperCase.HotKey:=hkTranslateToUpperCase;
   fm.hkTranslateToLowerCase.HotKey:=hkTranslateToLowerCase;
   fm.hkTranslateToRussian.HotKey:=hkTranslateToRussian;
   fm.hkTranslateToEnglish.HotKey:=hkTranslateToEnglish;
   fm.edDefaultDir.Text:=DefaultBackUpDir;
   fm.chbViewDateInListView.Checked:=isViewDateInListView;
   fm.chbViewPath.Checked:=isViewPath;
   fm.chbChangeDocument.Checked:=isSaveDocumentOnView;
   fm.chbRefreshForm.Checked:=isRefreshFormOnDocumentLoad;
   fm.chbDeleteQuiteInReestr.Checked:=isDeleteQuiteInReestr;
   fm.chbViewDeleteQuiteInReestr.Checked:=isViewDeleteQuiteInReestr;
   fm.udDayDoverOffset.Position:=DayDoverOffset;
   fm.chbDisableDefaultOnForm.Checked:=isDisableDefaultOnForm;
   fm.edUpdateInfoFile.Text:=UpdateInfoFile;
   fm.chbViewUpdateInfo.Checked:=isViewUpdateInfo;
   fm.chbViewHintOnFocus.Checked:=isViewHintOnFocus;
   fm.chbViewReminder.Checked:=isViewReminder;
   fm.chbAutoUpdateWords.Checked:=isAutoBuildWords;
   fm.chbViewWhoCert.Checked:=isViewWhoCert;
   fm.chbDocumentLock.Checked:=isDocumentLock;
   fm.chbNotViewHereditaryDeal.Checked:=isNotViewHereditaryDeal;
   fm.chbExpandConst.Checked:=isExpandConst;
   fm.chbQuestionBackup.Checked:=isQuestionBackup;
   fm.chbSelectDatabase.Checked:=isSelectDatabase;
   fm.chbCheckEmptySumm.Checked:=isCheckEmptySumm;

   fm.chbExpandConstClick(nil);

   fm.ChangeFlag:=false;
   fm.isSetAll:=true;
   if fm.ShowModal=mrOk then begin

    fm.SaveDatabases;
    isClearTempDir:=fm.chbDelTempFile.Checked;

    isBackUpFirst:=fm.chbFirstArch.Checked;
    isBackUpLast:=fm.chbLastArch.Checked;
    isBackUpTime:=fm.chbTimeArch.Checked;
    BackUpTime:=fm.udTimeArch.Position;
    RestoreSleep:=fm.udRestoreSleep.Position;
    tmBackUp.Interval:=60*1000*BackUpTime;
    tmBackUp.Enabled:=isBackUpTime;
    BackUpFreeze:=fm.udFreezeArch.Position;
    FileHelp:=fm.edFileHelp.Text;
    isCloseWord:=fm.chbTextPClose.Checked;

    hkTranslateToUpperCase:=fm.hkTranslateToUpperCase.HotKey;
    hkTranslateToLowerCase:=fm.hkTranslateToLowerCase.HotKey;
    hkTranslateToRussian:=fm.hkTranslateToRussian.HotKey;
    hkTranslateToEnglish:=fm.hkTranslateToEnglish.HotKey;

    RegisterAllHotKeys;

    DefaultBackUpDir:=fm.edDefaultDir.Text;
    isViewDateInListView:=fm.chbViewDateInListView.Checked;
    if Assigned(fmDocTree) then fmDocTree.ColumnCountChanged;
    if Assigned(fmDocTreeCarring) then fmDocTreeCarring.ColumnCountChanged;
    if Assigned(fmSearchDoc) then fmSearchDoc.ColumnCountChanged;

    isViewPath:=fm.chbViewPath.Checked;
    isSaveDocumentOnView:=fm.chbChangeDocument.Checked;
    isRefreshFormOnDocumentLoad:=fm.chbRefreshForm.Checked;
    isDeleteQuiteInReestr:=fm.chbDeleteQuiteInReestr.Checked;
    isViewDeleteQuiteInReestr:=fm.chbViewDeleteQuiteInReestr.Checked;
    DayDoverOffset:=fm.udDayDoverOffset.Position;
    isDisableDefaultOnForm:=fm.chbDisableDefaultOnForm.Checked;
    UpdateInfoFile:=fm.edUpdateInfoFile.Text;
    isViewUpdateInfo:=fm.chbViewUpdateInfo.Checked;
    isViewHintOnFocus:=fm.chbViewHintOnFocus.Checked;
    isViewReminder:=fm.chbViewReminder.Checked;
    isAutoBuildWords:=fm.chbAutoUpdateWords.Checked;
    isViewWhoCert:=fm.chbViewWhoCert.Checked;
    isDocumentLock:=fm.chbDocumentLock.Checked;
    isNotViewHereditaryDeal:=fm.chbNotViewHereditaryDeal.Checked;
    isExpandConst:=fm.chbExpandConst.Checked;
    isQuestionBackup:=fm.chbQuestionBackup.Checked;
    isSelectDatabase:=fm.chbSelectDatabase.Checked;
    isCheckEmptySumm:=fm.chbCheckEmptySumm.Checked;

    CheckPermissions;

    if fm.ChangeFlag then begin

      SaveToIni;
      RefreshAll;
    end;   
   end;
  finally
   fm.Free;
  end;
end;

procedure TfmMain.tmBackUpTimer(Sender: TObject);
begin
  tmBackUp.OnTimer:=nil;
  CreateBackUp('');
  tmBackUp.OnTimer:=tmBackUpTimer;
end;

procedure TfmMain.AppOnMess(var Msg: TMsg; var Handled: Boolean);
begin
  if Msg.message=MessageID then begin
    ShowWindow(Application.Handle,SW_Restore);
    Handled:=true;
  end;
  if Msg.message=WM_HOTKEY then begin
    case Msg.wParam of
     ConstHotKeyUpperCase: TranslateText(tttUpper);
     ConstHotKeyLowerCase: TranslateText(tttLower);
     ConstHotKeyToRussian: TranslateText(tttRussian);
     ConstHotKeyToEnglish: TranslateText(tttEnglish);
    end;
  end;
  case Msg.message of
    CM_ENTER: begin
      if isViewHintOnFocus then begin

      end;
    end;
  end;
end;

procedure TfmMain.miViewViewNewClick(Sender: TObject);
begin
 if NewForm<>nil then begin
   NewForm.Close;
   NewForm:=nil;
 end;
 if Sender=miViewViewNew Then begin
  miViewViewNew.Checked:=true;
  SetViewType(vtView);
 end;
 if Sender=miViewEditNew Then begin
  miViewEditNew.Checked:=true;
  SetViewType(vtEdit);
 end;
 SetViewTypeForAllForms;
end;

procedure TfmMain.miWindowCascadeNewClick(Sender: TObject);
begin
   Cascade;
end;

procedure TfmMain.miWindowVertNewClick(Sender: TObject);
begin
  TileMode:=tbVertical;
  Tile;
end;

procedure TfmMain.miWindowGorizNewClick(Sender: TObject);
begin
  TileMode:=tbHorizontal;
  Tile;
end;

procedure TfmMain.miWindowMinAllNewClick(Sender: TObject);
begin
  MinimizeOrRestore(true);
end;

procedure TfmMain.miWindowResAllNewClick(Sender: TObject);
begin
  MinimizeOrRestore(false);
end;

procedure TfmMain.miRBTypeReestrClick(Sender: TObject);
begin
 if fmTypeReestr=nil then begin
  fmTypeReestr:=TfmTypeReestr.Create(Application);
  fmTypeReestr.LoadFilter;
  fmTypeReestr.ActiveQuery;
  fmTypeReestr.bibOk.Visible:=false;
  fmTypeReestr.FormStyle:=fsMDIChild;
 end;
 if fmTypeReestr<>nil then begin
  fmTypeReestr.BringToFront;
  fmTypeReestr.Show;
 end;
end;

procedure TfmMain.tlbRBTypeReestrClick(Sender: TObject);
begin
  miRBTypeReestrClick(nil);
end;

procedure TfmMain.tlbRBOperationsClick(Sender: TObject);
begin
  miRBOperationClick(nil);
end;

procedure TfmMain.miRBOperationClick(Sender: TObject);
begin
 if fmOperation=nil then begin
  fmOperation:=TfmOperation.Create(Application);
  fmOperation.LoadFilter;
  fmOperation.ActiveQuery;
  fmOperation.bibOk.Visible:=false;
  fmOperation.FormStyle:=fsMDIChild;
 end;
 if fmOperation<>nil then begin
  fmOperation.BringToFront;
  fmOperation.Show;
 end;
end;

procedure TfmMain.miRBMaskClick(Sender: TObject);
begin
 if fmMask=nil then begin
  fmMask:=TfmMask.Create(Application);
  fmMask.LoadFilter;
  fmMask.ActiveQuery;
  fmMask.bibOk.Visible:=false;
  fmMask.FormStyle:=fsMDIChild;
 end;
 if fmMask<>nil then begin
  fmMask.BringToFront;
  fmMask.Show;
 end;
end;

procedure TfmMain.tlbRBMaskClick(Sender: TObject);
begin
  miRBMaskClick(nil);
end;

procedure TfmMain.miRBBlanksClick(Sender: TObject);
begin
 if fmBlanks=nil then begin
  fmBlanks:=TfmBlanks.Create(Application);
  fmBlanks.LoadFilter;
  fmBlanks.ActiveQuery;
  fmBlanks.bibOk.Visible:=false;
  fmBlanks.FormStyle:=fsMDIChild;
 end;
 if fmBlanks<>nil then begin
  fmBlanks.BringToFront;
  fmBlanks.Show;
 end;
end;

procedure TfmMain.miRBCaseClick(Sender: TObject);
begin
 if fmCase=nil then begin
  fmCase:=TfmCase.Create(Application);
  fmCase.LoadFilter;
  fmCase.ActiveQuery;
  fmCase.bibOk.Visible:=false;
  fmCase.FormStyle:=fsMDIChild;
 end;
 if fmCase<>nil then begin
  fmCase.BringToFront;
  fmCase.Show;
 end;
end;

procedure TfmMain.tlbRbCaseClick(Sender: TObject);
begin
  miRBCaseClick(nil);
end;

procedure TfmMain.miRefreshAllClick(Sender: TObject);
begin
 RefreshAll;
end;

procedure TfmMain.miLoginNewClick(Sender: TObject);
var
  fm: TfmLogin;
  Buffer: string;
begin
  fm:=TfmLogin.Create(nil);
  try
    fm.ActiveQuery;
    fm.cbUsers.Text:=UserName;
    if fm.ShowModal=mrOk then begin

//      MinimizeOrRestore(true);

      UserID:=fm.UserID;
      UserName:=fm.UserName;
      Buffer:='';
      if LocalDb.ReadParam(SDb_ParamProgramm,Buffer) then
        Caption:=Format(SMainCaption,[Buffer])+' - '+UserName;
      CheckPermissions;
      RefreshAll;
      fmMain.SetViewTypeForAllForms;

    end;
  finally
   fm.Free;
  end;
end;

procedure TfmMain.tlbRefreshAllClick(Sender: TObject);
begin
  miRefreshAllClick(nil);
end;

procedure TfmMain.tlbOptionsClick(Sender: TObject);
begin
  miOptionsClick(nil);
end;

procedure TfmMain.miSaveArchClick(Sender: TObject);
begin
  sd.InitialDir:=ExtractFileDir(Application.ExeName);
  sd.FileName:=LastSaveArch;
  if not sd.Execute then exit;
  CreateBackUp(sd.FileName);
  LastSaveArch:=sd.FileName;
end;

procedure TfmMain.miLoadArchClick(Sender: TObject);
begin
  od.InitialDir:=ExtractFileDir(Application.ExeName);
  od.FileName:=LastLoadArch;
  if not od.Execute then exit;
  RestoreBackUp(od.FileName);
  LastLoadArch:=od.FileName;
end;

procedure TfmMain.tmCheckOnTimer(Sender: TObject);
begin
  tmCheck.Enabled:=false;
  CheckPatch;
  tmCheck.Interval:=GetRndTime;
  tmCheck.Enabled:=true;
end;

procedure TfmMain.miInstrHelpClick(Sender: TObject);
begin
  if not RunAnyFile(FileHelp) then
     showerror(Application.Handle,'�� ������� ��������� ���� ������.');
end;

procedure TfmMain.miRBMarkCarClick(Sender: TObject);
begin
 if fmMarkCar=nil then begin
  fmMarkCar:=TfmMarkCar.Create(Application);
  fmMarkCar.LoadFilter;
  fmMarkCar.ActiveQuery;
  fmMarkCar.bibOk.Visible:=false;
  fmMarkCar.FormStyle:=fsMDIChild;
 end;
 if fmMarkCar<>nil then begin
  fmMarkCar.BringToFront;
  fmMarkCar.Show;
 end;
end;

procedure TfmMain.tlbRBMarkCarClick(Sender: TObject);
begin
  miRBMarkCarClick(nil);
end;

procedure TfmMain.miRBColorClick(Sender: TObject);
begin
 if fmColor=nil then begin
  fmColor:=TfmColor.Create(Application);
  fmColor.LoadFilter;
  fmColor.ActiveQuery;
  fmColor.bibOk.Visible:=false;
  fmColor.FormStyle:=fsMDIChild;
 end;
 if fmColor<>nil then begin
  fmColor.BringToFront;
  fmColor.Show;
 end;
end;

procedure TfmMain.tlbRBColorClick(Sender: TObject);
begin
  miRBColorClick(nil);
end;

procedure TfmMain.miRBLicenseClick(Sender: TObject);
begin
 if fmLicense=nil then begin
  fmLicense:=TfmLicense.Create(Application);
  fmLicense.LoadFilter;
  fmLicense.ActiveQuery;
  fmLicense.bibOk.Visible:=false;
  fmLicense.FormStyle:=fsMDIChild;
 end;
 if fmLicense<>nil then begin
  fmLicense.BringToFront;
  fmLicense.Show;
 end;
end;

procedure TfmMain.tlbRBLicenseClick(Sender: TObject);
begin
  miRBLicenseClick(nil);
end;

procedure TfmMain.miRBNotariusClick(Sender: TObject);
begin
 if fmNotarius=nil then begin
  fmNotarius:=TfmNotarius.Create(Application);
  fmNotarius.LoadFilter;
  fmNotarius.ActiveQuery;
  fmNotarius.bibOk.Visible:=false;
  fmNotarius.FormStyle:=fsMDIChild;
 end;
 if fmNotarius<>nil then begin
  fmNotarius.BringToFront;
  fmNotarius.Show;
 end;
end;

procedure TfmMain.tlbRBNotariusClick(Sender: TObject);
begin
  miRBNotariusClick(nil);
end;

procedure TfmMain.miSearchInReestrClick(Sender: TObject);
begin
 if fmSearchReestr=nil then begin
  fmSearchReestr:=TfmSearchReestr.Create(Application);
  fmSearchReestr.LoadFilter;
  fmSearchReestr.ActiveQuery;
  if fmSearchReestr.FlagActive then
   fmSearchReestr.FormStyle:=fsMDIChild;
 end else begin
  fmSearchReestr.LoadFilter;
  fmSearchReestr.ActiveQuery;
  if fmSearchReestr.FlagActive then
   fmSearchReestr.FormStyle:=fsMDIChild;
 end;
 if (fmSearchReestr<>nil)and(fmSearchReestr.FlagActive)then begin
  fmSearchReestr.BringToFront;
  fmSearchReestr.Show;

 end;
end;

procedure TfmMain.tlbSearhInReestrClick(Sender: TObject);
begin
  miSearchInReestrClick(nil);
end;

procedure TfmMain.miPanelButClick(Sender: TObject);
begin
  tlbMain.Visible:=true;
end;


procedure TfmMain.FormShow(Sender: TObject);
begin
  stbStatus.Invalidate;
  Left:=Screen.Width div 2 - Width div 2;
  Top:=Screen.Height div 2 - Height div 2;
end;

procedure TfmMain.MenuItemReceptionNotaryClick(Sender: TObject);
var
   fm: TReceptionForm;
begin
   fm:=TReceptionForm.Create(nil);
   try
     fm.ShowModal;
   finally
     fm.Free;
   end;
end;

procedure TfmMain.miSuperReportClick(Sender: TObject);
var
   fm: TfmSuperReport;
begin
   fm:=TfmSuperReport.Create(nil);
   try
     if fm.ShowModal=mrOk then
      fm.ReportView;
   finally
     fm.Free;
   end;
end;

procedure TfmMain.miSearchNumInreestrClick(Sender: TObject);
begin
 if fmSearchNumInReestr=nil then begin
  fmSearchNumInReestr:=TfmSearchNumInReestr.Create(Application);
  fmSearchNumInReestr.ActiveQuery;
 end else begin
  fmSearchNumInReestr.ActiveQuery;
 end;
 fmSearchNumInReestr.BringToFront;
 fmSearchNumInReestr.Show;

end;

procedure TfmMain.spbWorkYearClick(Sender: TObject);
begin
  EnterWorkDate(false);
  spbWorkYear.Caption:=Format(ConstWorkDate,[FormatDateTime(fmtDate,WorkDate)]);
end;

procedure TfmMain.miChangeWorkYearClick(Sender: TObject);
begin
 spbWorkYearClick(nil);
end;

procedure TfmMain.miCarringDocClick(Sender: TObject);
begin
  if fmDocTreeCarring=nil then begin
    fmDocTreeCarring:=TfmDocTreeCarring.Create(Application);
  end;
  fmDocTreeCarring.isConnect:=false;
  if ConnectServer(DataBaseNameCar) then begin
    fmDocTreeCarring.isConnect:=true;
    fmDocTreeCarring.ConnectDataBaseNameCar;
    fmDocTreeCarring.edBaseDir.Text:=DataBaseNameCar;
    fmDocTreeCarring.ActiveQuery;
   end;
  fmDocTreeCarring.FormStyle:=fsMDIChild;
  fmDocTreeCarring.BringToFront;

end;

procedure TfmMain.CNKeyDown(var Message: TWMKeyDown);
begin
 inherited;
 FormKeyDown(Self,Message.CharCode,[]);
end;

procedure TfmMain.CNKeyUp(var Message: TWMKeyUp);
begin
  inherited;
  FormKeyUp(Self,Message.CharCode,[]);
end;

procedure TfmMain.miSearchDocClick(Sender: TObject);
begin
 if fmSearchDoc=nil then begin
  fmSearchDoc:=TfmSearchDoc.Create(Application);
  fmSearchDoc.LoadFilter;
  fmSearchDoc.ActiveQuery;
  if fmSearchDoc.FlagActive then
   fmSearchDoc.FormStyle:=fsMDIChild;
 end else begin
  fmSearchDoc.LoadFilter;
  fmSearchDoc.ActiveQuery;
  if fmSearchDoc.FlagActive then
   fmSearchDoc.FormStyle:=fsMDIChild;
 end;
 if (fmSearchDoc<>nil)and(fmSearchDoc.FlagActive)then begin
  fmSearchDoc.BringToFront;
  fmSearchDoc.Show;
 end;
end;

procedure TfmMain.miRBConstClick(Sender: TObject);
begin
 if fmConst=nil then begin
  fmConst:=TfmConst.Create(Application);
  fmConst.LoadFilter;
  fmConst.ActiveQuery;
  fmConst.bibOk.Visible:=false;
  fmConst.FormStyle:=fsMDIChild;
 end;
 if fmConst<>nil then begin
  fmConst.BringToFront;
  fmConst.Show;
 end;
end;

procedure TfmMain.cmbHelperChange(Sender: TObject);
begin
  LastHelperIndex:=cmbHelper.ItemIndex;
  Windows.SetFocus(fmDocReestr.Handle);
  fmDocReestr.Grid.SetFocus;
end;

procedure TfmMain.tlbCurrentFormClick(Sender: TObject);
begin
  miCurrentFormClick(nil);
end;

procedure TfmMain.miCurrentFormClick(Sender: TObject);
begin
 if (NewForm<>nil)and(Assigned(NewForm)) then begin
   NewForm.BringToFront;
   ShowWindow(NewForm.Handle,SW_RESTORE);
 end;
end;

procedure TfmMain.miRBNotarialActionClick(Sender: TObject);
begin
 if fmRBNotarialAction=nil then begin
  fmRBNotarialAction:=TfmRBNotarialAction.Create(Application);
  fmRBNotarialAction.LoadFilter;
  fmRBNotarialAction.ActiveQuery;
  fmRBNotarialAction.bibOk.Visible:=false;
  fmRBNotarialAction.FormStyle:=fsMDIChild;
 end;
 if fmRBNotarialAction<>nil then begin
  fmRBNotarialAction.BringToFront;
  fmRBNotarialAction.Show;
 end;
end;

procedure TfmMain.miStatisticReportClick(Sender: TObject);
var
   fm: TfmStatisticReport;
begin
   fm:=TfmStatisticReport.Create(nil);
   try
     if fm.ShowModal=mrOk then
      fm.ReportView;
   finally
     fm.Free;
   end;
end;

procedure TfmMain.miRBHereditarydealClick(Sender: TObject);
begin
 if fmHereditaryDeal=nil then begin
  fmHereditaryDeal:=TfmHereditaryDeal.Create(Application);
  fmHereditaryDeal.LoadFilter;
  fmHereditaryDeal.ActiveQuery;
  fmHereditaryDeal.bibOk.Visible:=false;
  fmHereditaryDeal.FormStyle:=fsMDIChild;
 end;
 if fmHereditaryDeal<>nil then begin
  fmHereditaryDeal.BringToFront;
  fmHereditaryDeal.Show;
 end;
end;

procedure TfmMain.miRBSubsClick(Sender: TObject);
begin
 if fmSubs=nil then begin
  fmSubs:=TfmSubs.Create(Application);
  fmSubs.LoadFilter;
  fmSubs.ActiveQuery;
  fmSubs.bibOk.Visible:=false;
  fmSubs.FormStyle:=fsMDIChild;
 end;
 if fmSubs<>nil then begin
  fmSubs.BringToFront;
  fmSubs.Show;
 end;
end;

procedure TfmMain.miRBSubsValueClick(Sender: TObject);
begin
 if fmSubsValue=nil then begin
  fmSubsValue:=TfmSubsValue.Create(Application);
  fmSubsValue.LoadFilter;
  fmSubsValue.ActiveQuery;
  fmSubsValue.bibOk.Visible:=false;
  fmSubsValue.FormStyle:=fsMDIChild;
 end;
 if fmSubsValue<>nil then begin
  fmSubsValue.BringToFront;
  fmSubsValue.Show;
 end;
end;

procedure TfmMain.N8Click(Sender: TObject);
begin
 if fmRBPeople=nil then begin
  fmRBPeople:=TfmRBPeople.Create(Application);
  fmRBPeople.LoadFilter;
  fmRBPeople.ActiveQuery;
  fmRBPeople.bibOk.Visible:=false;
  fmRBPeople.FormStyle:=fsMDIChild;
  fmRBPeople.bibOk.OnClick:=fmRBPeople.MR;
  fmRBPeople.Grid.OnDblClick:=fmRBPeople.bibChangeClick;

 end;
 if fmRBPeople<>nil then begin
  fmRBPeople.BringToFront;
  fmRBPeople.Show;
 end;


end;

procedure TfmMain.miOperationPatchUtilClick(Sender: TObject);
var
  fm: TfmPatchUtil;
begin
  fm:=TfmPatchUtil.Create(nil);
  try
   if fm.ShowModal=mrOk then begin

   end;
  finally
    fm.Free;
  end;
end;

procedure TfmMain.miRuleForElementClick(Sender: TObject);
begin
 if fmRBRuleForElement=nil then begin
  fmRBRuleForElement:=TfmRBRuleForElement.Create(Application);
  fmRBRuleForElement.LoadFilter;
  fmRBRuleForElement.ActiveQuery;
  fmRBRuleForElement.bibOk.Visible:=false;
  fmRBRuleForElement.FormStyle:=fsMDIChild;
  fmRBRuleForElement.bibOk.OnClick:=fmRBRuleForElement.MR;
  fmRBRuleForElement.Grid.OnDblClick:=fmRBRuleForElement.bibChangeClick;

 end;
 if fmRBRuleForElement<>nil then begin
  fmRBRuleForElement.BringToFront;
  fmRBRuleForElement.Show;
 end;


end;

procedure TfmMain.tlbutReestrClick(Sender: TObject);
begin
  ShowWindow(fmDocReestr.Handle,SW_RESTORE);
  fmDocReestr.Show;
  fmDocReestr.BringToFront;
end;

procedure TfmMain.tlbbutDocTreeClick(Sender: TObject);
begin
  ShowWindow(fmDocTree.Handle,SW_RESTORE);
  fmDocTree.Show;
  fmDocTree.BringToFront;
end;

procedure TfmMain.tlbbutHereditaryDealClick(Sender: TObject);
begin
  miRBHereditarydealClick(nil);
end;

procedure TfmMain.miUpdateInfoClick(Sender: TObject);
begin
  ViewUpdateInfo;
end;

procedure TfmMain.miRbReminderClick(Sender: TObject);
begin
 if fmRbReminder=nil then begin
  fmRbReminder:=TfmRbReminder.Create(Application);
  fmRbReminder.LoadFilter;
  fmRbReminder.ActiveQuery;
  fmRbReminder.bibOk.Visible:=false;
  fmRbReminder.FormStyle:=fsMDIChild;
 end;
 if fmRbReminder<>nil then begin
  fmRbReminder.BringToFront;
  fmRbReminder.Show;
 end;
end;

procedure TfmMain.miRbRenovationClick(Sender: TObject);
begin
 if fmRenovation=nil then begin
  fmRenovation:=TfmRenovation.Create(Application);
  fmRenovation.LoadFilter;
  fmRenovation.ActiveQuery;
  fmRenovation.bibOk.Visible:=false;
  fmRenovation.FormStyle:=fsMDIChild;
 end;
 if fmRenovation<>nil then begin
  fmRenovation.BringToFront;
  fmRenovation.Show;
 end;
end;

procedure TfmMain.miOperationUpdateWordsClick(Sender: TObject);
var
  TIP: TInfoEnterPeriod;
  dbegin,dend: TDateTime;
begin
  FillChar(TIP,SizeOf(TIP),0);
  TIP.DateBegin:=Now;
  TIP.DateEnd:=Now;
  TIP.TypePeriod:=tepDay;
  if ViewEnterPeriod(@TIP) then begin
    dbegin:=StrToDate(DateToStr(TIP.DateBegin));
    dend:=StrToDate(DateToStr(TIP.DateEnd))+StrToTime('23:59:59');

    UpdateWordsInReestr(dbegin,dend);
  end;
end;

procedure TfmMain.miGraphVisitClick(Sender: TObject);
begin
 if fmGraphVisit=nil then begin
  fmGraphVisit:=TfmGraphVisit.Create(Application);
  fmGraphVisit.LoadFilter;
  fmGraphVisit.ActiveQuery;
  fmGraphVisit.bibOk.Visible:=false;
  fmGraphVisit.FormStyle:=fsMDIChild;
 end;
 if fmGraphVisit<>nil then begin
  fmGraphVisit.BringToFront;
  fmGraphVisit.Show;
 end;
end;

procedure TfmMain.tlbGraphVisitClick(Sender: TObject);
begin
  miGraphVisitClick(nil);
end;

procedure TfmMain.SelectNotariusById(NotariusId: Integer);
var
  i: Integer;
  IHI: TInfoHelperItem;
begin
  for i:=0 to cmbHelper.Items.Count-1 do begin
    IHI:=TInfoHelperItem(cmbHelper.Items.Objects[i]);
    if IHI.NotId=NotariusId then begin
      cmbHelper.ItemIndex:=i;
      break;
    end;
  end;
end;

procedure TfmMain.ViewWhoCert;
var
  fm: TfmSelectNoarius;
begin
  if isViewWhoCert then begin
    fm:=TfmSelectNoarius.Create(nil);
    try
      fm.FillNotarius(true);
      fm.lbNotarius.Caption:='�������� ��� ��������';

      fm.meInfo.Lines.Text:='�������� ��������� ��� ��� ��������� ��� ��������������� �������� ����������������� �������';
      if fm.ShowModal=mrOk then begin
        SelectNotariusById(Integer(fm.cmbNotarius.Items.Objects[fm.cmbNotarius.ItemIndex]));
      end;
    finally
      fm.Free;
    end;
  end;
end;


procedure TfmMain.miDeleteDocLocksClick(Sender: TObject);
begin
  if RemoveDocumentsLocks then
    ShowInfo(ConstRemoveDocumentsLooksSuccess);
end;

procedure TfmMain.miListHereditaryDealClick(Sender: TObject);
var
   fm: TfmListHereditaryDeal;
begin
   fm:=TfmListHereditaryDeal.Create(nil);
   try
     if fm.ShowModal=mrOk then
      fm.ReportView;
   finally
     fm.Free;
   end;
end;

procedure TfmMain.miChamberClick(Sender: TObject);
begin
 if fmChamber=nil then begin
   fmChamber:=TfmChamber.Create(Application);
   fmChamber.LoadFilter;
   fmChamber.ActiveQuery;
   fmChamber.bibOk.Visible:=false;
   fmChamber.FormStyle:=fsMDIChild;
 end;
 if fmChamber<>nil then begin
   fmChamber.BringToFront;
   fmChamber.Show;
 end;
end;

procedure TfmMain.miNotaryClick(Sender: TObject);
begin
 if fmNotary=nil then begin
   fmNotary:=TfmNotary.Create(Application);
   fmNotary.LoadFilter;
   fmNotary.ActiveQuery;
   fmNotary.bibOk.Visible:=false;
   fmNotary.FormStyle:=fsMDIChild;
 end;
 if fmNotary<>nil then begin
   fmNotary.BringToFront;
   fmNotary.Show;
 end;
end;

procedure TfmMain.tlbNotaryClick(Sender: TObject);
begin
  miNotaryClick(nil);
end;

procedure TfmMain.miSelectDatabaseClick(Sender: TObject);
begin
  if SelectDatabase(true) then begin
    CheckPermissions;
    RefreshAll;
  end;
end;

procedure TfmMain.SetLogoPosition(Visible: Boolean);
begin
  PanelLogo.Anchors:=[];
  if Visible then begin
    PanelLogo.Left:=ClientWidth-PanelLogo.Width-10;
    PanelLogo.Top:=ClientHeight-PanelLogo.Height-50;
    PanelLogo.Anchors:=[akRight,akBottom];
    PanelLogo.Visible:=true;
  end else begin
    PanelLogo.Visible:=false;
    PanelLogo.Anchors:=[akLeft,akTop];
    PanelLogo.Top:=50;
  end;
end;

procedure TfmMain.FormResize(Sender: TObject);
begin
  SetLogoPosition(false);
  SetLogoPosition(true);
end;

procedure TfmMain.ImageLogoClick(Sender: TObject);
var
  Buffer: String;
begin
  Buffer:='';
  if LocalDb.ReadParam(SDb_ParamSite,Buffer) then begin
    ShellExecute(0,'open',PChar(Buffer),nil,nil,SW_SHOW);
  end;
end;


end.

