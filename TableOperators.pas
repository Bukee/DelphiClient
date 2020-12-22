unit TableOperators;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.Grids;

type
  TForm9 = class(TForm)
    StringGrid1: TStringGrid;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N3: TMenuItem;
    procedure exit(Sender: TObject);
    procedure ADD(Sender: TObject);
    procedure ORO(Sender: TObject);
    procedure operatorsOR(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    Add_operators:boolean;
    OR_operators:boolean;
    id:string;{ Public declarations }
  end;

var
  Form9: TForm9;

implementation

{$R *.dfm}

uses TestClientUnit;


procedure TForm9.ADD(Sender: TObject);
var s:string;
begin
  Add_operators:=true;
end;

procedure TForm9.ORO(Sender: TObject);
begin
  OR_operators:=true;
end;

procedure TForm9.exit(Sender: TObject);
begin
close();
end;

procedure TForm9.operatorsOR(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  var massage:string;
  var id1:string;
  var ACol, ARow: integer;

  function mI(var s1:string):string;
  var a,i1:integer;
  var s:string;
  begin
  s:=s1;
  i1:=1;
    while s[i1]<>'È' do begin
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
   massage := StringGrid1.Cells[ACol,ARow];
   if Acol = 1 then if massage <> ''  then id1:= mI(massage);
   if massage = ''  then id1 := '';
   id:=id1;
end;



end.
