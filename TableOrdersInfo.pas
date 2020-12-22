unit TableOrdersInfo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.Grids;

type
  TForm10 = class(TForm)
    StringGrid1: TStringGrid;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    procedure exit(Sender: TObject);
    procedure ADD(Sender: TObject);
    procedure ORO(Sender: TObject);
    procedure StringGrid1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
  ID:string;
  Add_operators:boolean;
    OR_operators:boolean;
    { Public declarations }
  end;

var
  Form10: TForm10;

implementation

{$R *.dfm}

uses TestClientUnit;

procedure TForm10.exit(Sender: TObject);
begin
ID:='notpress';
close();
end;

procedure TForm10.ORO(Sender: TObject);
begin
  OR_operators:=true;
end;

procedure TForm10.StringGrid1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  var massage:string;
  var ACol, ARow: integer;


  function mI(var s1:string):string;
  var a,i1:integer;
  var s:string;
  begin
  s:=s1;
  i1:=1;
  while (s[i1]<>'i') or (i1 < 2) do begin
     if s[i1] = 'd' then a:=i1+2;
     i1:=i1+1;
  end;
  s:=copy(s,a,i1-a);
  val(s,a,i1);
  str(a,s);
  mI:=s;
  end;


begin
   StringGrid1.MouseToCell(X, Y, ACol, ARow);
   massage := StringGrid1.Cells[1,ARow];
   //form8.showmodal();
   //if massage = '' then  else ID:=massage;
  //if True then

   ID:= massage;
   //stringGrid1.Cells[1,1]:='rrrrr';
   //close();

   end;

procedure TForm10.ADD(Sender: TObject);
var s:string;
begin
  Add_operators:=true;
end;

end.
