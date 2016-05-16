unit polz;

{$mode objfpc}{$H+}

interface

uses
Classes, SysUtils, mssqlconn, sqldb, odbcconn, FileUtil, Forms, Controls,
Graphics, Dialogs, StdCtrls, ComCtrls, ExtCtrls, maskedit, Spin, EditBtn,
ExtDlgs, Calendar;

type
TTeachers = class
private

 idTeach: array [1..100] of integer;
end;


{ TForm1 }

TForm1 = class(TForm)
  Anketa: TGroupBox;
  ForSem: TPanel;
  ForIDEdit: TEdit;
  ForID: TPanel;
  ForSemEdit: TEdit;
  Ok: TPanel;
  PC1: TPageControl;
  StartScreen: TGroupBox;
  MSSQLConnection1: TMSSQLConnection;
  SQLQuery1: TSQLQuery;
  SQLTransaction1: TSQLTransaction;
  View: TTreeView;

  procedure Button1Click(Sender: TObject);
  procedure ForIDEditChange(Sender: TObject);
  procedure ForIDEditKeyPress(Sender: TObject; var Key: char);
  procedure FormActivate(Sender: TObject);
  function getnum(gr: string; sem: integer; tea: integer): integer;
  procedure Index1Click(Sender: TObject);
  procedure IndexClick(Sender: TObject);
  procedure OkClick(Sender: TObject);
  procedure PosAnkClick(Sender: TObject);
  //procedure ReadyClick(Sender: TObject;gr:string;sem:integer;idtea:integer);
  procedure ViewChange(Sender: TObject; Node: TTreeNode);



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





procedure TForm1.Button1Click(Sender: TObject);
begin

end;

procedure TForm1.ForIDEditChange(Sender: TObject);
begin

end;

procedure TForm1.ForIDEditKeyPress(Sender: TObject; var Key: char);
begin
  if not (key in ['0'..'9', #8]) then
    key := #0;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  Form1.Width := 300;
end;

procedure TForm1.Index1Click(Sender: TObject);
begin

end;

procedure TForm1.IndexClick(Sender: TObject);
begin

end;


function tform1.getnum(gr: string; sem: integer; tea: integer): integer;
begin
  SqlQuery1.SQL.Clear;
  SqlQuery1.SQL.Add(
    'exec InsertInf @CurrentGroupId = :GR, @CurrentSemesterId = :Se,@SelectedTeacherId=:TeaId');
  SQLQuery1.ParamByName('GR').AsString := gr;
  SQLQuery1.ParamByName('Se').AsInteger := sem;
  SQLQuery1.ParamByName('TeaId').AsInteger := Tea;
  SqlQuery1.Open;
end;


procedure TForm1.OkClick(Sender: TObject);
var
  i: integer;
  s: string;
begin
    try
    SqlQuery1.SQL.Clear;
    SqlQuery1.SQL.Add('exec StudSem @ID_Student = :ID_S, @Sem = :Se');
    SQLQuery1.ParamByName('ID_S').AsInteger := StrToInt(ForIDEdit.Text);
    SQLQuery1.ParamByName('Se').AsInteger := StrToInt(ForSemEdit.Text);
    SqlQuery1.Open;
    SqlQuery1.First;
    Form1.Width := 400;
    View.Visible := True;
    while not SqlQuery1.EOF do
      begin
      Startscreen.Visible := False;
      View.Items.Add(idteach, SQLQuery1.FieldByName('Surname').AsString);
      SQLQuery1.Next;
      Form1.Width := 90;
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



procedure TForm1.PosAnkClick(Sender: TObject);
begin

end;




procedure TForm1.ViewChange(Sender: TObject; Node: TTreeNode);
var
  Nya, index, Readybutt: TPanel;
  Kawai: TEdit;
  Kisa: TspinEdit;
  number:integer;
  n, max, sm, i: integer;
  k: char;
  s, sem: integer;
  gr, dates: string;
  tt: TTabSheet;
  today: TDateTime;
begin

  dates := FormatDateTime('dd.mm.yyyy"-"hh:nn:ss:zzz', Now);

  selectedNode := node;
  s := node.Index;


  max := 0;
  sm := 0;
  n := 56;
  i := 0;

  SQLQuery1.Sql.Clear;
  SqlQuery1.SQL.Add('SELECT Group_numb FROM Student where id_student = ' +
    ForIDEdit.Text);
  //showmessage (  SqlQuery1.SQL[0]);
  SQLQuery1.Open;
  //showmessage (  SqlQuery1.Fields[0].asString);
  if not Sqlquery1.EOF then
    gr := SQLQuery1.Fields[0].AsString;
  SqlQuery1.Close;

  SQLQuery1.Sql.Clear;
  SqlQuery1.SQL.Add('SELECT semestre FROM Group_semestre where semestre = ' +
    ForSemEdit.Text);
  SQLQuery1.Open;
  if not Sqlquery1.EOF then
    sem := StrToInt(SQLQuery1.Fields[0].AsString);
  SqlQuery1.Close;



  SQLQuery1.Sql.Clear;
  SqlQuery1.SQL.Add('SELECT * FROM Question');
  SqlQuery1.Open;

  while not SqlQuery1.EOF do

    begin
    //SqlQuery1.SQL.Add('SELECT Number FROM Group_semestre');
    //Panel1.caption  := SqlQuery1.FieldByName('Number').AsString;


    pc1.Visible := True;
    tt := pc1.AddTabSheet;

    pc1.ActivePage := tt;

    index := TPanel.Create(pc1.ActivePage);
    index.Parent := pc1.ActivePage;
    Nya := TPanel.Create(pc1.ActivePage);
    Nya.Parent := pc1.ActivePage;
    Index.Caption := SQLQuery1.FieldByName('ID_Anketa').AsString;
    Nya.Caption := SQLQuery1.FieldByName('Quest_Text').AsString;
    Kisa := TSpinEdit.Create(pc1.ActivePage);
    Kisa.Parent := pc1.ActivePage;
    readybutt := TPanel.Create(pc1.ActivePage);
    readybutt.Parent := pc1.ActivePage;
    readybutt.Caption := 'Готов!';

    with readybutt do
      begin
      Width := 72;
      Height := 30;
      left := 10;
      top := 180;
      end;
    with index do
      begin
      Width := 72;
      Height := 30;
      left := 8;
      top := 6;

      with Nya do
        begin
        Width := Nya.Canvas.TextWidth(Nya.Caption);
        Height := 30;
        Top := n;
        Left := 8;
        BevelOuter := bvNone;
        BorderWidth := 10;
        Color := clSilver;
        end;
      with kisa do
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

      number := getnum(gr,sem,idteach);
      tt.Caption := IntToStr(i + 1);
      i := StrToInt(tt.Caption);
      SqlQuery1.Next;

      end;




    pc1.ActivePageIndex := 0;

    sm := (max div 3);
    ANketa.Width := 400 + sm;
    pc1.ActivePage.Width := nya.Width + 70;
    form1.Width := pc1.ActivePage.Width + 100;

    end;
  SqlQuery1.Close;

end;














end.
