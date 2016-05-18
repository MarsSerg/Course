unit AnkForm;

{$mode objfpc}{$H+}

interface

uses
Classes, SysUtils, mssqlconn, sqldb, odbcconn, FileUtil, Forms, Controls,
Graphics, Dialogs, StdCtrls, ComCtrls, ExtCtrls, maskedit, Spin, EditBtn;

type

{ TForm1 }

TForm1 = class(TForm)
  Anketa: TGroupBox;
  DateEdit1: TDateEdit;
  ForSem: TPanel;
  ForIDEdit: TEdit;
  ForID: TPanel;
  ForSemEdit: TEdit;
  Ok: TPanel;
  StartScreen: TGroupBox;
  Index: TPanel;
  Index1: TPanel;
  MSSQLConnection1: TMSSQLConnection;
  Ready: TPanel;
  PosAnk: TGroupBox;
  SQLQuery1: TSQLQuery;
  SQLTransaction1: TSQLTransaction;
  View: TTreeView;

  procedure Button1Click(Sender: TObject);
  procedure ForIDEditChange(Sender: TObject);
  procedure ForIDEditKeyPress(Sender: TObject; var Key: char);

  procedure Index1Click(Sender: TObject);
  procedure IndexClick(Sender: TObject);
  procedure OkClick(Sender: TObject);
  procedure PosAnkClick(Sender: TObject);
  procedure ReadyClick(Sender: TObject);
  procedure ViewChange(Sender: TObject; Node: TTreeNode);

  procedure ViewClick(Sender: TObject);

  procedure ViewGetSelectedIndex(Sender: TObject; Node: TTreeNode);

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
itindex: array [1..100] of integer;
passed: integer;



procedure gg(A: tsqlquery; b: ttreeview);
var
  node: TTreeNode;
  n, s: integer;
begin
  a.SQL.Add('SELECT *  FROM dbo.Teacher');
  //a.Open;
  while not a.EOF do
    begin
    node := b.Items.Add(nil, a.FieldByName('Surname').AsString);
    a.Next;
    end;
  a.Close;
  a.SQL.Clear;

end;

procedure TForm1.Button1Click(Sender: TObject);
var
  i: integer;
  node: TTreeNode;
begin
  //node := view.c;
end;

procedure TForm1.ForIDEditChange(Sender: TObject);
begin

end;

procedure TForm1.ForIDEditKeyPress(Sender: TObject; var Key: char);
begin
  if not (key in ['0'..'9', #8]) then
    key := #0;
end;

procedure TForm1.Index1Click(Sender: TObject);
begin

end;

procedure TForm1.IndexClick(Sender: TObject);
begin

end;

procedure TForm1.OkClick(Sender: TObject);
var
  i: integer;
  s: string;
begin
  try
  SqlQuery1.SQL.Clear;
  // s:= 'SELECT *  FROM dbo.Student where id_student = ''' +
  // ForIDEdit.Text + ''' ' ;

  SqlQuery1.SQL.Add('exec studsem @ID_Student = :ID_S, @Sem = :Se');
  SQLQuery1.ParamByName('ID_S').AsInteger := StrToInt(ForIDEdit.Text);
  SQLQuery1.ParamByName('Se').AsInteger := StrToInt(ForSemEdit.Text);
  SqlQuery1.Open;
  SqlQuery1.First;
  while not SqlQuery1.EOF do

    begin

    Startscreen.Visible := False;
    // gg(SQLQuery1, View);
    View.Items.Add(nil, SQLQuery1.FieldByName('Surname').AsString);
    SQLQuery1.Next;

    end;

    SqlQuery1.Close;
   except

    on E: mssqlconn.EMSSQLDatabaseError do
    begin
    ShowMessage(e.Message);
  //  ShowMessage('ilggoigodbklni');
    SqlQuery1.Close;
    end;
   end;

end;



procedure TForm1.PosAnkClick(Sender: TObject);
begin

end;

procedure TForm1.ReadyClick(Sender: TObject);
var
  j, i: integer;
begin
  passed := passed + 1;
  // for i:= 1 to
  //SQLQuery1.ExecSQL UpdatePassnum @ID = passed , @id_quest =   ;
end;



procedure TForm1.ViewChange(Sender: TObject; Node: TTreeNode);
var
  Nya: TPanel;
  Kawai: TEdit;
  Kisa: TspinEdit;
  n, max, sm: integer;
  k: char;
  s: integer;
begin
  selectedNode := node;
  s := node.Index;
  max := 0;
  sm := 0;
  n := 56;

  SQLQuery1.Sql.Clear;
  SqlQuery1.SQL.Add('SELECT * FROM Question');
  SqlQuery1.Open;


  while not SqlQuery1.EOF do

    begin
    Nya := TPanel.Create(PosAnk);
    Nya.Parent := posAnk;
    Index.Caption := SQLQuery1.FieldByName('ID_Anketa').AsString;
    Nya.Caption := SQLQuery1.FieldByName('Quest_Text').AsString;
    //Kawai := TEdit.Create(PosAnk);
    //Kawai.Parent := posAnk;
    Kisa := TSpinEdit.Create(PosAnk);
    Kisa.Parent := posAnk;
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
    ////with Kawai do
    ////  begin
    ////  Text := '0';
    ////  Width := 32;
    ////  Height := 23;
    ////  Top := n + 30;
    ////  Left := 8;
    ////  BorderWidth := 10;
    ////  MaxLength := 2;
    ////  OnKeyPress:=@Kawaikeypress;
    ////  end;
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

    //if not ((strtoint(kawai.Text) >= 0) and (strtoint(kawai.Text) <= 10)) then
    //  begin
    //  ShowMessage('Не более 10 баллов');
    //  end;

    ;


    sm := nya.Width;

    if sm > max then
      max := sm;


    SqlQuery1.Next;
    n := n + 60;
    end;
  SqlQuery1.Close;
  SqlQuery1.SQL.Clear;
  posank.Height:=544 +  ;
  PosAnk.Width := 296 + max;
  sm := (max div 3);
  ANketa.Width := 400 + sm;
  Form1.Width := Anketa.Width;
  POsAnk.Visible := True;

end;

//procedure Tform1.KawaiKeyPress(Sender: TObject; var Key: char);
//var
//  k: integer;
//begin
//  if not (key in ['0'..'9', #8]) then
//    key := #0;

//end;

procedure TForm1.ViewClick(Sender: TObject);
begin

end;



procedure TForm1.ViewGetSelectedIndex(Sender: TObject; Node: TTreeNode);

begin

end;




end.




