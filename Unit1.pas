unit Unit1;

interface



uses
  shellapi, jcldatetime,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvBaseDlg, JvSelectDirectory, ExtCtrls, JvExExtCtrls, JvExtComponent, JvPanel, StdCtrls, JvExStdCtrls,
  JvMemo,
  JvListBox, JvDriveCtrls, JvExControls, JvxCheckListBox, JvSimpleXml, ComCtrls, JvExComCtrls, JvStatusBar, Mask,
  JvExMask, JvToolEdit, Menus, JvMenus, JvLabel, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP;

const cRELEASE='2';

type
  TForm1 = class(TForm)
    JvSelectDirectory1: TJvSelectDirectory;
    JvxCheckListBox1: TJvxCheckListBox;
    JvPanel3: TJvPanel;
    JvStatusBar1: TJvStatusBar;
    xml: TJvSimpleXML;
    bDoBackup: TButton;
    JvMemo1: TJvMemo;
    JvDirectoryEdit1: TJvDirectoryEdit;
    JvMainMenu1: TJvMainMenu;
    miVerzeichnisAdd: TMenuItem;
    JvLabel1: TJvLabel;
    miHilfe: TMenuItem;
    miAbout: TMenuItem;
    IdHTTP1: TIdHTTP;
    miC4U: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure bDoBackupClick(Sender: TObject);
    procedure JvxCheckListBox1ClickCheck(Sender: TObject);
    procedure JvDirectoryEdit1Change(Sender: TObject);
    procedure miVerzeichnisAddClick(Sender: TObject);
    procedure JvxCheckListBox1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure miAboutClick(Sender: TObject);
    procedure JvMemo1Click(Sender: TObject);
    procedure miC4UClick(Sender: TObject);
  private
    { Private-Deklarationen }
    sLetztesBackup: string;
    function ShowMemo(bShow: boolean): boolean;

    function GetFileName(fn: string): string;

  public
    { Public-Deklarationen }
    procedure SaveSettings;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}



// http://www.delphipraxis.net/topic1451_dateioperationen+mit+shfileoperation.html by sakura
function DoFileWork(aOperation: FILEOP_FLAGS; aFrom, aTo: pwidechar; Flags: FILEOP_FLAGS): Integer;
var
  FromPath, ToPath: pwidechar;
  SHFileOpStruct: TSHFileOpStruct;
begin
  FromPath := aFrom;
  ToPath := aTo;
  with SHFileOpStruct do
  begin
    Wnd := 0;
    wFunc := aOperation;
    pFrom := FromPath;
    if ToPath <> '' then
      pTo := ToPath
    else
      pTo := nil;
    fFlags := Flags;
  end; // structure
  Result := SHFileOperationW(SHFileOpStruct);
end;

function TForm1.ShowMemo(bShow: boolean): boolean;
begin
  JvMemo1.Visible := bShow;
  JvxCheckListBox1.Visible := not JvMemo1.Visible;
end;

function TForm1.GetFileName(fn: string): string;
begin
  Result := ExtractFileDir(Application.ExeName) + '\' + fn;
end;

procedure TForm1.JvDirectoryEdit1Change(Sender: TObject);
begin
  SaveSettings;
end;

procedure TForm1.JvMemo1Click(Sender: TObject);
begin
  ShowMemo(false);
end;

procedure TForm1.JvxCheckListBox1ClickCheck(Sender: TObject);
begin
  SaveSettings;
end;

procedure TForm1.JvxCheckListBox1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  i: longint;
begin
  if Key = VK_DELETE then
  begin
    for i := 0 to JvxCheckListBox1.items.Count - 1 do
      if JvxCheckListBox1.Selected[i] then
      begin
        JvxCheckListBox1.items.Delete(i);
        break;
      end;

    SaveSettings;
  end;
end;

procedure TForm1.miAboutClick(Sender: TObject);
begin
  JvMemo1.text := 'backupgogogo:' + #13#10 + ' --bak: auto. backup' + #13#10 + '--exit: exit program' + #13#10 +
    #13#10 + 'url: http://github.com/inselberg/backupgogogo/blob/master/backupgogogo.exe';
  ShowMemo(true);
end;

procedure TForm1.miC4UClick(Sender: TObject);
var
  html: string;
  suche: string;
begin
  JvStatusBar1.simpletext := 'checking....';
//  ShowMemo(true);
  suche := '<div class="message"><pre><a href="/inselberg/backupgogogo/commit/';
  html := IdHTTP1.get('http://github.com/inselberg/backupgogogo/blob/master/backupgogogo.exe');
  html := copy(html, pos(suche, html) + length(suche), length(html));
  html := copy(html, pos('>', html) + 1, length(html));
  html := copy(html, 1, pos('</a>', html) - 1);
  JvMemo1.text := (html);
  if html = cRELEASE+'nd release' then
    JvStatusBar1.simpletext := 'newst version.'
  else
    JvStatusBar1.simpletext := 'newer version available.';
end;

procedure TForm1.miVerzeichnisAddClick(Sender: TObject);
var
  str: string;
begin
  if JvSelectDirectory1.Execute then
  begin
    str := JvSelectDirectory1.Directory;
    if JvxCheckListBox1.items.indexof(str) = -1 then
    begin
      JvxCheckListBox1.items.Add(str);
      JvxCheckListBox1.Checked[JvxCheckListBox1.items.indexof(str)] := true;
    end;

    SaveSettings;
  end;

end;

function lz(value: longint; len: byte = 2): string;
var
  s: String;
begin
  s := inttostr(value);
  while length(s) < len do
    s := '0' + s;
  Result := s;
end;

procedure TForm1.bDoBackupClick(Sender: TObject);
var
  r, i: longint;
  Year, Month, Day: Word;
  quelle, ziel: string;
  dt: tdatetime;
begin
  JvMemo1.Lines.clear;
  dt := now;
  sLetztesBackup := datetimetostr(dt);

  decodeDate(dt, Year, Month, Day);
  ziel := JvDirectoryEdit1.Directory + '\' + inttostr(Year) + '-' + lz(Month) + '-' + lz(Day) + '__' + lz
    (HourOfTime(dt)) + '_' + lz(MinuteOfTime(dt)) + '_' + lz(SecondOfTime(dt));
  r := 0;
  for i := 0 to JvxCheckListBox1.items.Count - 1 do
    if JvxCheckListBox1.Checked[i] then
    begin
      quelle := JvxCheckListBox1.items[i];
      JvStatusBar1.simpletext := quelle + '->' + ziel;
      r := r + DoFileWork(FO_COPY, pwidechar(quelle + #0#0), pwidechar(ziel + #0 + #0), FOF_RENAMEONCOLLISION);
    end;

  JvStatusBar1.simpletext := 'Backup beendet.';
  if r > 0 then
    JvStatusBar1.simpletext := 'Mögliche Fehler im Bakup';

  SaveSettings;
end;

procedure TForm1.SaveSettings;
var
  i: longint;
  e: TJvSimpleXMLElem;
begin

  xml.Root.name := 'Einstellungen';
  xml.Root.items.clear;

  // backup
  with xml.Root.items.Add('Letztes_Backup') do
    value := sLetztesBackup;

  // ziel
  with xml.Root.items.Add('Ziel') do
    value := JvDirectoryEdit1.Directory;

  // src
  e := xml.Root.items.Add('Quelle');
  for i := 0 to JvxCheckListBox1.items.Count - 1 do
  begin
    with e.items.Add('Ordner') do
    begin
      with items.Add('Name') do
        value := JvxCheckListBox1.items[i];
      with items.Add('Checked') do
        value := BoolToStr(JvxCheckListBox1.Checked[i]);
    end;
  end;
  xml.SaveToFile(GetFileName('settings.xml'));
  JvMemo1.text := xml.SaveToString;
end;

function GetXMLChildValue(xml: TJvSimpleXML; itemname: String; var ctrl: longint): string;
var
  i: longint;
  e: TJvSimpleXMLElem;
  str: string;

begin
  str := '';
  ctrl := -2;
  e := xml.Root.items.ItemNamed[itemname];
  if e = nil then
    ctrl := -1
  else
    with e.items do
    begin
      str := e.value;
      ctrl := e.ChildsCount;
    end;
  Result := str;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i: longint;
  e: TJvSimpleXMLElem;
  str: string;
  ctrl: longint;
begin
  try
    xml.LoadFromFile(GetFileName('settings.xml'));
  except
  end;

  xml.Root.name := 'Einstellungen';
  e := xml.Root.items.ItemNamed['Quelle'];
  if e <> nil then
    with e.items do
      for i := 0 to Count - 1 do
      begin
        e := item[i];
        str := e.items.ItemNamed['Name'].value;
        if JvxCheckListBox1.items.indexof(str) = -1 then
        begin
          JvxCheckListBox1.items.Add(str);
          JvxCheckListBox1.Checked[JvxCheckListBox1.items.indexof(str)] := e.items.ItemNamed['Checked'].BoolValue;
        end;
      end;

  sLetztesBackup := GetXMLChildValue(xml, 'Letztes_Backup', ctrl);
  // str:=GetXMLChildValue(xml,'Ziel',ctrl);

  // muss hinten stehen wegen autorefresh... fixen ;)
  // zielordner auslesen
  str := GetXMLChildValue(xml, 'Ziel', ctrl);
  if ctrl < 0 then
    str := '<Zielordner auswählen>';
  JvDirectoryEdit1.Directory := str;

  Form1.Caption := Application.Title + ' ' + sLetztesBackup;

  str := '';
  for i := 1 to paramcount do
  begin
    str := str + paramstr(i);
    if paramstr(i) = '--bak' then
      bDoBackupClick(Sender);
    if paramstr(i) = '--exit' then
      Application.Terminate;
  end;

  JvStatusBar1.simpletext := str;
  ShowMemo(false);
end;

end.
