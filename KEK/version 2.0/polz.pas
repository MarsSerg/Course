unit polz;

{$mode objfpc}{$H+}

interface

uses
Classes, SysUtils, mssqlconn, sqldb, odbcconn, FileUtil, Forms, Controls,
Graphics, Dialogs, StdCtrls, ComCtrls, ExtCtrls, maskedit, Spin, EditBtn,
ExtDlgs, Calendar,Math;

type
TTeachers = class
private

  idTeach: integer;
end;




{ TForm1 }

TForm1 = class(TForm)
  Anketa: TGroupBox;
  Button1: TButton;
  ForSem: TPanel;
  ForIDEdit: TEdit;
  ForID: TPanel;
  ForSemEdit: TEdit;
  Ok: TPanel;
  Panel1: TPanel;
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

  procedure ForIDEditKeyPress(Sender: TObject; var Key: char);
  procedure FormActivate(Sender: TObject);
  function getnum(gr: string; sem: integer; tea: integer): integer;


  procedure OkClick(Sender: TObject);
  procedure MyResize(NewWidth : Integer);

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
Idnode,pointes,idQue, IdAnket:integer;






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


procedure TForm1.OkClick(Sender: TObject);
var
  new: integer;
  s: string;
  tree: tteachers;
  l: TTreeNode;
begin
    new:=90;
    form1.Height:=552;
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
      ShowMessage(e.Message);
      SqlQuery1.Close;
      end;
    end;

end;














//procedure TForm1.FinalClick(date: string; idStud: integer;
//idQuest: integer; idAnk: integer; number: integer; points: integer);
//var
//  idpass: integer;
//begin
//  SqlQuery2.SQL.Clear;
//  SqlQuery2.SQL.Add('exec Pass  @date =: Date,@IDStud=:stud,@idquest=:que,@idank=:ank,@num=:num,@points=:points');
//  SQLQuery2.ParamByName('Date').AsString := Date;
//  SQLQuery2.ParamByName('Stud').AsInteger := idStud;
//  SQLQuery2.ParamByName('Que').AsInteger := IdQuest;
//  SQLQuery2.ParamByName('Ank').AsInteger := IdAnk;
//  SQLQuery2.ParamByName('Num').AsInteger := Number;
//  SQLQuery2.ParamByName('Points').AsInteger := Points;
//  showmessage(SQLQuery2.Sql.Text);
//  SqlQuery2.ExecSQL;
//end;


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
  pc1.ActivePage.Destroy;

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
  //SQLTransaction1.StartTransaction;
  SqlQuery2.SQL.Clear;
  SqlQuery2.SQL.Add('exec Pass  @date=:date,@IDStud=:IDstud,@idquest=:IdQuest,@idank=:IdAnk,@num=:num,@points=:points');
  SQLQuery2.ParamByName('date').AsDate:=StrToDate(dates);
  SQLQuery2.ParamByName('IdStud').AsInteger:=idstudent;
  SQLQuery2.ParamByName('IdQuest').AsInteger:=idQue;
  SQLQuery2.ParamByName('IdAnk').AsInteger:=idAnket;
  SQLQuery2.ParamByName('Num').AsInteger:=Number;
  SQLQuery2.ParamByName('Points').AsInteger:=Pointes;
  //showmessage(SQLQuery2.SQL);
  SQLQuery2.ExecSQL;
  SQLTransaction1.Commit;

end;






procedure TForm1.ViewChange(Sender: TObject; Node: TTreeNode);
var
  Nya, index, Readybutt: TPanel;
  Kisa: TspinEdit;
  k: char;
  max,n,i,sm,number,j: integer;
  gr: string;
  tt: TTabSheet;


  begin
    max := 0;
    sm := 0;
    n := 56;
    i := 0;



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
    idque := SQLQuery1.FieldByName('ID_Quest').AsInteger;
    IdAnket := SQLQuery1.FieldByName('ID_Anketa').AsInteger;
    Index.Caption := IntToStr(IdAnket);
    Nya.Caption := SQLQuery1.FieldByName('Quest_Text').AsString;
    Kisa := TSpinEdit.Create(pc1.ActivePage);
    Kisa.Parent := pc1.ActivePage;

    forindex(index);
    fornya (Nya,n);
    forkisa (kisa,n);


      tt.Caption := IntToStr(i + 1);
      i := StrToInt(tt.Caption);

      SqlQuery1.Next;

      pointes := Kisa.Value;


    sm := (max div 3);
    panel1.Caption:=inttostr(pc1.ActivePage.TabIndex);

    pc1.Width := nya.Width +250;

    ANketa.Width := pc1.Width+100 ;

    form1.Width := Anketa.Width ;




    end;
  Pc1.ActivePageIndex := 0;
  //MyResize(Pc1.ActivePage.Width);
  SqlQuery1.Close;



end;














end.
