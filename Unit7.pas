unit Unit7;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm7 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    IPAdrees: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form7: TForm7;

implementation

{$R *.dfm}

uses TestClientUnit;

procedure TForm7.Button1Click(Sender: TObject);
begin
TestClientForm.Timer1.Enabled:=true;
Hide();
TestClientForm.ShowModal();
close();

end;

procedure TForm7.FormCreate(Sender: TObject);
begin
 //TestClientForm.Timer1.Enabled:=false;
end;

procedure TForm7.FormShow(Sender: TObject);
begin
 TestClientForm.Timer1.Enabled:=false;
end;

end.
