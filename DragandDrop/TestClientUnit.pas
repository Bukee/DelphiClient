﻿unit TestClientUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, Vcl.ExtCtrls, Vcl.Grids,
  Data.DB, Vcl.DBGrids, Vcl.ComCtrls;

type
  TTestClientForm = class(TForm)
    IPAddressLabel: TLabel;
    IPAddressEdit: TEdit;
    PortLabel: TLabel;
    PortEdit: TEdit;
    URLLabel: TLabel;
    URLEdit: TEdit;
    SendButton: TButton;
    HTTP: TIdHTTP;
    Memo1: TMemo;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    ScrollBar1: TScrollBar;
    ScrollBar2: TScrollBar;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    Panel14: TPanel;
    Panel15: TPanel;
    Panel16: TPanel;
    Panel17: TPanel;
    ScrollBar3: TScrollBar;
    Label1: TLabel;
    Label2: TLabel;
    procedure SendButtonClick(Sender: TObject);
    procedure Panel1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure UpDown1Click(Sender: TObject; Button: TUDBtnType);
    procedure ScrollBar1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Panel1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
    procedure Panel3MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
    procedure Panel4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
    procedure Panel4MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
    procedure Memo1DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Memo1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ScrollBar2Change(Sender: TObject);
    procedure ScrollBar3Change(Sender: TObject);
    procedure Panel5DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure Panel6DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure Panel7DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure Panel8DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure Panel5DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Panel6DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Panel7DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Panel8DragDrop(Sender, Source: TObject; X, Y: Integer);

    procedure ColorReset(Sender:TObject;Panel:TPanel);
  private
    { Private declarations }
  public
     var mas:array[0..100] of string[30];
     var masC:array[0..100] of array [0..100] of string[30];
     var left:array[0..3] of integer;
     var top:array[0..3] of integer;
     var masnext:array[0..100] of integer;
     { Public declarations }
  end;

var
  TestClientForm: TTestClientForm;

implementation

{$R *.dfm}



procedure TTestClientForm.FormShow(Sender: TObject);
var s:string;
var t:integer;
begin
  scrollbar2.Max:=1;
  panel1.Caption:='jopa';
  panel2.Caption:='old';
  panel3.Caption:='old1';
  panel4.Caption:='old2';
  mas[0]:=panel1.Caption;
  mas[1]:=panel2.Caption;
  mas[2]:=panel3.Caption;
  mas[3]:=panel4.Caption;
  mas[4]:='new';
  mas[5]:='new1';
  mas[6]:='new2';
  mas[7]:='new3';
  mas[8]:='new4';
  left[0]:=panel1.Left;
  top[0]:=panel1.Top;
  left[1]:=panel2.Left;
  top[1]:=panel2.Top;
  left[2]:=panel3.Left;
  top[2]:=panel3.Top;
  left[3]:=panel4.Left;
  top[3]:=panel4.top;
  masC[0,0]:='курьер1';
  masC[1,0]:='курьер2';
  masC[2,0]:='курьер3';
  masC[3,0]:='курьер4';
  masC[4,0]:='курьер5';
  t:=1;
  for var I:integer := 0 to 100 do begin
    for var K:integer := 1 to 1 do begin
        str(I,s);
        masC[I,K]:='Заказ' + s;
    end;
  end;

  for var I:integer := 0 to 100 do begin
     t:=1;
     while masC[I,t] <> '' do
     t:=t+1;
     masNext[I]:=t;
  end;

  ScrollBar2Change(Sender);
end;

procedure TTestClientForm.ColorReset(Sender:TObject;Panel:TPanel);
begin
   if Panel.Caption = '' then panel.Color:=clRed else panel.Color := clGreen;
end;

procedure TTestClientForm.Memo1DragDrop(Sender, Source: TObject; X, Y: Integer);
begin
   if Source = panel1 then Memo1.Lines.Add(panel1.Caption);
   if Source = panel2 then Memo1.Lines.Add(panel2.Caption);
   if Source = panel3 then Memo1.Lines.Add(panel3.Caption);
   if Source = panel4 then Memo1.Lines.Add(panel4.Caption);
end;

procedure TTestClientForm.Panel1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    TPanel(Sender).BeginDrag(True);
    ReleaseCapture;
    Panel1.Perform(WM_SYSCOMMAND, $F012, 0);
    Panel1MouseUp(Sender, Button, Shift,X, Y);
end;



procedure TTestClientForm.Memo1DragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
   if Source = panel1 then Accept := Source = panel1;
   if Source = panel2 then Accept := Source = panel2;
   if Source = panel3 then Accept := Source = panel3;
   if Source = panel4 then Accept := Source = panel4;
end;

procedure TTestClientForm.Panel1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   panel1.Left:=left[0];
   panel1.top:=top[0];
end;

procedure TTestClientForm.SendButtonClick(Sender: TObject);
var
  request : TStringStream;
  response : string;
  url : string;
begin
  HTTP.Request.ContentType := 'application/json';
  HTTP.Request.CharSet := 'utf-8';

  url := 'http://' + IPAddressEdit.Text + ':' + PortEdit.Text + URLEdit.Text;

  //request := TStringStream.Create(UTF8Encode(RequestMemo.Lines.Text));

  try
    response := HTTP.Post(url, request);
  except
    //ResponseMemo.Lines.Add('Не удалось подключится к серверу');
    exit;
  end;

 // ResponseMemo.Lines.Text := '';
 // ResponseMemo.Lines.Add(response);
end;

procedure TTestClientForm.UpDown1Click(Sender: TObject; Button: TUDBtnType);
var mas:array[0..4] of string[30];
begin

end;


 procedure TTestClientForm.ScrollBar1Change(Sender: TObject);
begin
  panel1.Caption:=mas[ScrollBar1.Position];
  panel2.Caption:=mas[ScrollBar1.Position+1];
  panel3.Caption:=mas[ScrollBar1.Position+2];
  panel4.Caption:=mas[ScrollBar1.Position+3];
end;


procedure TTestClientForm.ScrollBar2Change(Sender: TObject);
begin
   panel5.Caption:=masC[scrollbar2.Position,0];
   panel6.Caption:=masC[scrollbar2.Position + 1,0];
   panel7.Caption:=masC[scrollbar2.Position + 2,0];
   panel8.Caption:=masC[scrollbar2.Position + 3,0];
   ScrollBar3Change(Sender);
   ColorReset(Sender,panel9);
   ColorReset(Sender,panel10);
   ColorReset(Sender,panel11);
   ColorReset(Sender,panel12);
   ColorReset(Sender,panel13);
   ColorReset(Sender,panel14);
   ColorReset(Sender,panel15);
   ColorReset(Sender,panel16);
end;

procedure TTestClientForm.ScrollBar3Change(Sender: TObject);
begin
     panel9.Caption:=masC[scrollbar2.Position,scrollbar3.Position + 1];
     panel10.Caption:=masC[scrollbar2.Position,scrollbar3.Position + 2];
     panel11.Caption:=masC[scrollbar2.Position + 1,scrollbar3.Position + 1];
     panel12.Caption:=masC[scrollbar2.Position + 1,scrollbar3.Position + 2];
     panel13.Caption:=masC[scrollbar2.Position + 2,scrollbar3.Position + 1];
     panel14.Caption:=masC[scrollbar2.Position + 2,scrollbar3.Position + 2];
     panel15.Caption:=masC[scrollbar2.Position + 3,scrollbar3.Position + 1];
     panel16.Caption:=masC[scrollbar2.Position + 3,scrollbar3.Position + 2];
     ColorReset(Sender,panel9);
     ColorReset(Sender,panel10);
     ColorReset(Sender,panel11);
     ColorReset(Sender,panel12);
     ColorReset(Sender,panel13);
     ColorReset(Sender,panel14);
     ColorReset(Sender,panel15);
     ColorReset(Sender,panel16);
end;

procedure TTestClientForm.Panel2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    TPanel(Sender).BeginDrag(True);
    {ReleaseCapture;
    Panel2.Perform(WM_SYSCOMMAND, $F012, 0);
    Panel2MouseUp(Sender, Button, Shift,X, Y); }
end;

procedure TTestClientForm.Panel2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  panel2.Left:=left[1];
  panel2.top:=top[1];
end;

procedure TTestClientForm.Panel3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    TPanel(Sender).BeginDrag(True);
    {ReleaseCapture;
    Panel3.Perform(WM_SYSCOMMAND, $F012, 0);
    Panel3MouseUp(Sender, Button, Shift,X, Y); }
end;

procedure TTestClientForm.Panel3MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  panel3.Left:=left[2];
  panel3.top:=top[2];
end;

procedure TTestClientForm.Panel4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    TPanel(Sender).BeginDrag(True);
    {ReleaseCapture;
    Panel4.Perform(WM_SYSCOMMAND, $F012, 0);
    Panel4MouseUp(Sender, Button, Shift,X, Y); }
end;

procedure TTestClientForm.Panel4MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  panel4.Left:=left[3];
  panel4.top:=top[3];
end;

procedure TTestClientForm.Panel5DragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
   if Source = panel1 then Accept := Source = panel1;
   if Source = panel2 then Accept := Source = panel2;
   if Source = panel3 then Accept := Source = panel3;
   if Source = panel4 then Accept := Source = panel4;
end;

procedure TTestClientForm.Panel5DragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
   if Source = panel1 then masC[scrollbar2.Position,masNext[scrollbar2.Position]]:=panel1.Caption;
   if Source = panel2 then masC[scrollbar2.Position,masNext[scrollbar2.Position]]:=panel2.Caption;
   if Source = panel3 then masC[scrollbar2.Position,masNext[scrollbar2.Position]]:=panel3.Caption;
   if Source = panel4 then masC[scrollbar2.Position,masNext[scrollbar2.Position]]:=panel4.Caption;
   if (Source = panel1) or (Source = panel2) or (Source = panel3) or (Source = panel4) then inc(masNext[scrollbar2.Position],1);
   ScrollBar2Change(Sender);
end;

procedure TTestClientForm.Panel6DragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
   if Source = panel1 then Accept := Source = panel1;
   if Source = panel2 then Accept := Source = panel2;
   if Source = panel3 then Accept := Source = panel3;
   if Source = panel4 then Accept := Source = panel4;
end;

procedure TTestClientForm.Panel6DragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
   if Source = panel1 then masC[scrollbar2.Position + 1,masNext[scrollbar2.Position + 1]]:=panel1.Caption;
   if Source = panel2 then masC[scrollbar2.Position + 1,masNext[scrollbar2.Position + 1]]:=panel2.Caption;
   if Source = panel3 then masC[scrollbar2.Position + 1,masNext[scrollbar2.Position + 1]]:=panel3.Caption;
   if Source = panel4 then masC[scrollbar2.Position + 1,masNext[scrollbar2.Position + 1]]:=panel4.Caption;
   if (Source = panel1) or (Source = panel2) or (Source = panel3) or (Source = panel4) then inc(masNext[scrollbar2.Position + 1],1);
   ScrollBar2Change(Sender);
end;

procedure TTestClientForm.Panel7DragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
   if Source = panel1 then Accept := Source = panel1;
   if Source = panel2 then Accept := Source = panel2;
   if Source = panel3 then Accept := Source = panel3;
   if Source = panel4 then Accept := Source = panel4;
end;

procedure TTestClientForm.Panel7DragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
   if Source = panel1 then masC[scrollbar2.Position + 2,masNext[scrollbar2.Position + 2]]:=panel1.Caption;
   if Source = panel2 then masC[scrollbar2.Position + 2,masNext[scrollbar2.Position + 2]]:=panel2.Caption;
   if Source = panel3 then masC[scrollbar2.Position + 2,masNext[scrollbar2.Position + 2]]:=panel3.Caption;
   if Source = panel4 then masC[scrollbar2.Position + 2,masNext[scrollbar2.Position + 2]]:=panel4.Caption;
   if (Source = panel1) or (Source = panel2) or (Source = panel3) or (Source = panel4) then inc(masNext[scrollbar2.Position + 2],1);
   ScrollBar2Change(Sender);
end;

procedure TTestClientForm.Panel8DragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
   if Source = panel1 then Accept := Source = panel1;
   if Source = panel2 then Accept := Source = panel2;
   if Source = panel3 then Accept := Source = panel3;
   if Source = panel4 then Accept := Source = panel4;
end;

procedure TTestClientForm.Panel8DragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
   if Source = panel1 then masC[scrollbar2.Position + 3,masNext[scrollbar2.Position + 3]]:=panel1.Caption;
   if Source = panel2 then masC[scrollbar2.Position + 3,masNext[scrollbar2.Position + 3]]:=panel2.Caption;
   if Source = panel3 then masC[scrollbar2.Position + 3,masNext[scrollbar2.Position + 3]]:=panel3.Caption;
   if Source = panel4 then masC[scrollbar2.Position + 3,masNext[scrollbar2.Position + 3]]:=panel4.Caption;
   if (Source = panel1) or (Source = panel2) or (Source = panel3) or (Source = panel4) then inc(masNext[scrollbar2.Position + 3],1);
   ScrollBar2Change(Sender);
end;

end.
