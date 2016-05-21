unit polz;

{$mode objfpc}{$H+}

interface

uses
Classes, SysUtils, mssqlconn, sqldb, odbcconn, FileUtil, Forms, Controls,
Graphics, Dialogs, StdCtrls, ComCtrls, ExtCtrls, Spin, EditBtn,
ExtDlgs, Calendar,Math;

type
TTeachers = class
private

  idTeach: integer;
end;




{ TForm1 }

TForm1 = class(TForm)
  Anketa: TGroupBox;
  ForSem: TPanel;
  ForIDEdit: TEdit;
  ForID: TPanel;
  ForSemEdit: TEdit;
  Image1: TImage;
  Ok: TPanel;
  Button1: TPanel;
  PC1: TPageControl;
  SQLQuery2: TSQLQuery;
  StartScreen: TGroupBox;
  MSSQLConnection1: TMSSQLConnection;
  SQLQuery1: TSQLQuery;

  SQLTransaction1: TSQLTransaction;
  View: TTreeView;
  //procedure FinalClick(date: string; idStud: integer; idQuest: integer;
  //  idAnk: integer; number: integer; points: integer);
  // procedure FinalClick (date : string ; idStud : integer ; idQuest:integer ; idAnk : integer; number: integer; points:integer);
  procedure Button1Click(Sender: TObject);
  procedure Button1MouseDown(Sender: TObject; Button: TMouseButton;
		    Shift: TShiftState; X, Y: Integer);
  procedure Button1MouseUp(Sender: TObject; Button: TMouseButton;
		    Shift: TShiftState; X, Y: Integer);

  procedure ForIDEditKeyPress(Sender: TObject; var Key: char);
  procedure FormActivate(Sender: TObject);
  function getnum(gr: string; sem: integer; tea: integer): integer;
  procedure Image1Click(Sender: TObject);


  procedure OkClick(Sender: TObject);
  procedure MyResize(NewWidth : Integer);
  procedure OkMouseDown(Sender: TObject; Button: TMouseButton;
		    Shift: TShiftState; X, Y: Integer);
  procedure OkMouseUp(Sender: TObject; Button: TMouseButton;
		    Shift: TShiftState; X, Y: Integer);

  //procedure ReadyClick(Sender: TObject;gr:string;sem:integer;idtea:integer);
  procedure ViewChange(Sender: TObject; Node: TTreeNode);
  Function searchgroup : String;
  Function getsem : integer;
  procedure forindex (i:TPanel);
 procedure fornya (i:tpanel;n:integer);
 procedure forkisa (i:tspinedit;n:integer);
private

  { private declarations }
public

  { public declarations }
end;

var
Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }
var
selectedNode: TTreeNode;
Idnode,pointes,idQue, IdAnket,j:integer;
Kisa: TspinEdit;






 procedure TForm1.MyResize(NewWidth : Integer);
var
  J : Integer;
  N : Integer;
  S : Integer;
begin
  N := Abs(NewWidth - Self.Width);
  S := Sign(NewWidth - Self.Width);
For J := 1 To N Do
Begin
Self.Width := Self.Width + S;
Sleep(0);// <-- задержка
Application.ProcessMessages;// <-- обработать сообщения, чтоб все не висло
// Self.Update; // <-- иногда само не отрисовывается. тогда - раскоменнтировать.
End;
end;

procedure TForm1.OkMouseDown(Sender: TObject; Button: TMouseButton;
		  Shift: TShiftState; X, Y: Integer);
begin
      Ok.Color:=clGrayText;
end;

procedure TForm1.OkMouseUp(Sender: TObject; Button: TMouseButton;
		  Shift: TShiftState; X, Y: Integer);
begin
         Ok.Color:=clMedGray;
end;



procedure TForm1.ForIDEditKeyPress(Sender: TObject; var Key: char);
begin
  if not (key in ['0'..'9', #8]) then
    key := #0;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin

  form1.width:=300;
  form1.Height:=160;
  //form1.Top:= (Screen.Height-Height) div 2;
  form1.Left:= (Screen.Width-Width) div 2;
end;







function tform1.getnum(gr: string; sem: integer; tea: integer): integer;
begin
  SqlQuery2.SQL.Clear;
  SqlQuery2.SQL.Add(
    'exec InsertInf @CurrentGroupId = :GR, @CurrentSemesterId = :Se,@SelectedTeacherId=:TeaId');
  SQLQuery2.ParamByName('GR').AsString := gr;
  SQLQuery2.ParamByName('Se').AsInteger := sem;
  SQLQuery2.ParamByName('TeaId').AsInteger := Tea;
  SqlQuery2.Open;
  getnum := SQLQuery2.Fields[0].AsInteger;
  SQLQuery2.Close;
end;

procedure TForm1.Image1Click(Sender: TObject);
Var R:Word;
begin
R:=MessageDLG('Закончить анкету?',mtConfirmation,[mbYes,mbNo],0);
if R=mrYes then
   begin
    Application.Terminate;
   end;
if R=mrNo then
   begin
      exit;
   end;
end;


procedure TForm1.OkClick(Sender: TObject);
var
  new: integer;
  tree: tteachers;
  l: TTreeNode;
begin

    new:=90;
    form1.Height:=224;
    MyResize(new);
    try
    SqlQuery1.SQL.Clear;
    SqlQuery1.SQL.Add('exec StudSem @ID_Student = :ID_S, @Sem = :Se');
    SQLQuery1.ParamByName('ID_S').AsInteger := StrToInt(ForIDEdit.Text);
    SQLQuery1.ParamByName('Se').AsInteger := StrToInt(ForSemEdit.Text);
    SqlQuery1.Open;
    SqlQuery1.First;
    View.Visible := True;
    while not SqlQuery1.EOF do
      begin
      Startscreen.Visible := False;
      tree := TTeachers.Create();
      tree.idTeach := SQLQuery1.FieldByName('teacher_id').AsInteger;
      l := View.Items.add(nil, SQLQuery1.FieldByName('Surname').AsString);
      l.Data := tree;
      SQLQuery1.Next;
      end;
    SqlQuery1.Close;
    except
    on E: mssqlconn.EMSSQLDatabaseError do
      begin

      ShowMessage('Ytuydvcjsdvcj');
      SqlQuery1.Close;
      end;
    end;
end;

Function TForm1.searchgroup : String;
begin
    SQLQuery1.Sql.Clear;
    SqlQuery1.SQL.Add('SELECT Group_numb FROM Student where id_student = ' +
    ForIDEdit.Text);
    SQLQuery1.Open;
   if not Sqlquery1.EOF then
      searchgroup := SQLQuery1.Fields[0].AsString;
      SqlQuery1.Close;
end;

Function Tform1.getsem : integer;
begin
  SQLQuery1.Sql.Clear;
  SqlQuery1.SQL.Add('SELECT semestre FROM Group_semestre where semestre = ' +
  ForSemEdit.Text);
  SQLQuery1.Open;
  if not Sqlquery1.EOF then
  getsem := StrToInt(SQLQuery1.Fields[0].AsString);
  SqlQuery1.Close;
end;


procedure tform1.fornya (i:tpanel;n:integer);
begin
with i do
       begin
       Font.Name:='Franklin Gothic';
       Width := i.Canvas.TextWidth(i.Caption);
       Height := 30;
       Top := n;
       Left := 8;
       BevelOuter := bvNone;
       BorderWidth := 10;
       Color := clSilver;
       end;
end;

procedure tform1.forindex (i:TPanel);
begin
   with i do
      begin
      BorderStyle:=bsSingle;
      BorderWidth:=2;
      Font.Name:='Bernard Mt';
      Width := 72;
      Height := 30;
      left := 8;
      top := 6;
      end;
end;

procedure TForm1.forkisa (i:tspinedit;n:integer);
begin
  with i do
        begin
        Width := 52;
        Height := 23;
        Top := n + 30;
        Left := 8;
        BorderWidth := 10;
        MaxValue := 10;
        MinValue := 0;
        Increment := 1;
        end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  dates,gr:string;
  sem,IDstudent,Number:integer;
begin
  dates := FormatDateTime('dd.mm.yyyy', Now);
  gr:=searchgroup;
  sem:=getsem;
  number := getnum(gr, sem, Idnode);
  idstudent := StrToInt(ForIdEdit.Text);
  pointes:=TSpinEdit(pc1.ActivePage.Controls[2]).value;
  if pointes = 0 then
  begin
    ShowMessage('Пожалуйста, оцените преподавателя');
  end
  else
   begin
  SqlQuery2.SQL.Clear;
  SqlQuery2.SQL.Add('exec Pass  @date=:date,@IDStud=:IDstud,@idquest=:IdQuest,@idank=:IdAnk,@num=:num,@points=:points');
  SQLQuery2.ParamByName('date').AsDate:=StrToDate(dates);
  SQLQuery2.ParamByName('IdStud').AsInteger:=idstudent;
  SQLQuery2.ParamByName('IdQuest').AsInteger:=PC1.ActivePage.Tag;
  SQLQuery2.ParamByName('IdAnk').AsInteger:=idAnket;
  SQLQuery2.ParamByName('Num').AsInteger:=Number;
  SQLQuery2.ParamByName('Points').AsInteger:=Pointes;
  SQLQuery2.ExecSQL;
  SQLTransaction1.Commit;
  pc1.ActivePage.Destroy;
   end;
end;

procedure TForm1.Button1MouseDown(Sender: TObject; Button: TMouseButton;
		  Shift: TShiftState; X, Y: Integer);
begin
       Button1.Color:=clGrayText;
end;

procedure TForm1.Button1MouseUp(Sender: TObject; Button: TMouseButton;
		  Shift: TShiftState; X, Y: Integer);
begin
       Button1.Color:=clGray;
end;

procedure TForm1.ViewChange(Sender: TObject; Node: TTreeNode);
var
  Nya, index: TPanel;
  n,i: integer;
  tt: TTabSheet;
   begin
    n := 56;
    i := 0;
    j:=0;
  Button1.Visible:=true;
  selectedNode := node;
  idnode := TTeachers(node.Data).idTeach;
  SQLQuery1.Sql.Clear;
  SqlQuery1.SQL.Add('SELECT * FROM Question');
  SqlQuery1.Open;
   while not SqlQuery1.EOF do
    begin
     pc1.Visible := True;
     tt := pc1.AddTabSheet;
     pc1.ActivePage := tt;
     index := TPanel.Create(pc1.ActivePage);
     index.Parent := pc1.ActivePage;
     Nya := TPanel.Create(pc1.ActivePage);
     Nya.Parent := pc1.ActivePage;
     tt.Tag := SQLQuery1.FieldByName('ID_Quest').AsInteger;
     IdAnket := SQLQuery1.FieldByName('ID_Anketa').AsInteger;
     Index.Caption := IntToStr(IdAnket);
     Nya.Caption := SQLQuery1.FieldByName('Quest_Text').AsString;

     Kisa := TSpinEdit.Create(pc1.ActivePage);
     Kisa.Parent := pc1.ActivePage;
     kisa.tag:=tt.tag;
     forindex(index);
     fornya (Nya,n);
     forkisa (kisa,n);
      tt.Caption := IntToStr(i + 1);
      i := StrToInt(tt.Caption);
      j:=j+1;
      SqlQuery1.Next;

    pc1.Width := nya.Width +250;
    ANketa.Width := pc1.Width+100 ;
    form1.Width := Anketa.Width ;
    form1.Update;
    end;
  Pc1.ActivePageIndex := idque;
  SqlQuery1.Close;
end;
end.
