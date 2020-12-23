﻿unit TestClientUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, Vcl.Menus, Data.DB, System.JSON,
  Vcl.Grids, Vcl.ExtCtrls ;

type
  TTestClientForm = class(TForm)
    ResponseMemo: TMemo;
    HTTP: TIdHTTP;
    RequestMemo: TMemo;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    StringGrid1: TStringGrid;
    Timer1: TTimer;
    StringGrid2: TStringGrid;
    N2: TMenuItem;
    N3: TMenuItem;
    N5: TMenuItem;
    N4: TMenuItem;
   // procedure SendButtonClick(Sender: TObject);
    function URLOut(sender:TObject;url:string;massage:string):string;
    procedure MenuCouriers(Sender: TObject);
    procedure MenuOrders(Sender:TObject);
    procedure MenuOrdersInfo(Sender: TObject);
    procedure MenuOperators(Sender: TObject);
    procedure MenuProduct(Sender:Tobject);
    procedure IDSearch(Sender: TObject);
    procedure Timer(Sender:TObject);

    procedure MenuOperatorRun(Sender:TObject);
    procedure MenuOrdersInfoRun(Sender:TObject);
    procedure MenuProductRun(Sender: TObject);
    procedure MemoOrders(Sender:TObject);

    function loginPassword(Sender: TObject):boolean;

    procedure TableClear(Sender:TObject;Table:TStringGrid);

    procedure couriersAdd(Sender: TObject);
    function  couriersId(Sender: TObject;id:string):TJSONObject;
    function  couriersList(Sender: TObject):TJSONObject;
    procedure couriersDelete(Sender: TObject;id:string);
    procedure couriersUpdate(sender:Tobject;id:string);
    procedure couriersOR(Sender:TObject;id :string);

    function  operatorsList(sender:Tobject):TJSONObject;
    procedure operatorAdd(Sender: TObject);
    function  operatorId(Sender: TObject):TJSONObject;
    procedure operatorUpdate(Sender:TObject;id:string);
    procedure operatorDelete(Sender:TObject;id:string);
    procedure operatorOr(Sender:TObject;id :string);

    function  ordersList(Sender: TObject):TJSONObject;
    function  ordersId(Sender: TObject):TJSONObject;
    procedure ordersAdd(Sender:TObject);
    procedure ordersDelete(Sender:TObject;id:string);
    procedure ordersUpdate(Sender:TObject;id:string);
    procedure ordersOR(Sender:TObject;id:string);

    function  ordersInfoList(Sender:TObject;id:string):TJSONObject;
    function  ordersInfoId (Sender:TObject;id:string):TJSONObject;
    procedure ordersInfoAdd (Sender:TObject;id:string);
    procedure ordersInfoDelete(Sender:TObject;id:string);
    procedure ordersInfoUpdate(Sender:TObject;id:string);
    procedure ordersInfoOR(Sender:TObject;id:string);

    procedure productAdd(Sender:TObject);
    procedure ProductOr(Sender:TObject;id:string);
    procedure productDelete(Sender:TObject;id:string);
    procedure productUpdate(Sender:TObject;id:string);

    procedure StringGrid1Click(Sender: TObject);
    procedure RequestMemoDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure RequestMemoDragDrop(Sender, Source: TObject; X, Y: Integer);
    {procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean); }
    procedure StringGrid1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure StringGrid2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure openOrder(Sender: TObject);


    //procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
    //  Rect: TRect; State: TGridDrawState);



  private

    { Private declarations }
  public
    IDGlobal:String;
    OperatorRun:Boolean;
    OrdersIngoRun,ProductRun:Boolean;
    OrdersIndoId:string;
    { Public declarations }
  end;

var
  TestClientForm: TTestClientForm;

implementation

{$R *.dfm}
  uses unit1,unit2,unit3,unit4,unit5,unit6,unit7,TableC,TableOperators,TableOrdersInfo,tableProduct,
  Unit12, Unit13, tableO;




  //help


procedure TTestClientForm.IDSearch(Sender: TObject);
var JSON:TJSONObject;
 var I,R:integer;
 var JSONA: TJSONArray;
 var id,url,massage,massage1,massage2:string;
begin
    JSON:= operatorsList(Sender);
    url:='/operators/list/';
    massage:=URLOut(Sender,url,JSON.ToString());
    JSONA:= TJSONObject.ParseJSONValue(massage) as TJSONArray;
    for I := 0 to JSONA.Size() - 1 do begin
     JSON:=JSONA[I] as TJSONObject;
     id:=JSON.Values['id'].Value;
     massage1:=JSON.Values['login'].Value;
     if massage1 = form7.Edit1.Text then IDGlobal:=id;
    end;
    if IDGlobal = '' then requestMemo.lines.add('jopa');
    end;

function TTestClientForm.loginPassword(Sender: TObject):boolean;
var login,password,url:string;
var JSON:TJSONObject;
var JsonObject: TJSONObject;
begin
    try
    Timer1.Enabled:=false;
    loginPassword:=true;
    login:= form7.Edit1.Text;
    password:=form7.Edit2.Text;
    JsonObject:= TJSONObject.Create;
    JsonObject.AddPair('login', login)
        .AddPair('password',password);
    url:='/operators/login/';
    login:=URLOut(Sender,url, JsonObject.ToString());
    JSON:=TJSONObject.ParseJSONValue(login) as TJSONObject;
    login:=JSON.Values['status'].value;
   //requestMemo.Lines.Add(login);
    if login = 'login successfully' then  loginPassword:=true else loginPassword:= false;
    //Timer1.Enabled:=true;
    except

    end;


end;



procedure TTestClientForm.TableClear(Sender: TObject;Table:TStringGrid);
var i:integer;
begin
  with Table do
  for i:=0 to ColCount-1 do begin
    Table.RowHeights[I]:=24;
    Table.ColWidths[0]:= 0;
    Table.ColWidths[1]:=64;
    Cols[i].Clear;
  end;
end;

procedure TTestClientForm.Timer(Sender: TObject);
begin
    try
     if loginPassword(Sender) then begin
      IDSearch(Sender);
      MenuCouriers(Sender);
      MenuOrders(Sender);
      MenuOperators(Sender);
      MenuOrdersInfo(Sender);
      MenuProduct(Sender);
      MemoOrders(Sender);
     end
      else begin
           Timer1.Enabled:=false;
           TableClear(Sender,StringGrid2);
           TableClear(Sender,StringGrid1);
           form13.Showmodal();
           close();
           form7.Close();
           end;

    except

    end;
end;

//меню
 procedure TTestClientForm.MemoOrders(Sender: TObject);
 var JSON2:TJSONObject;
 var I,K,R:integer;
 var JSONA2: TJSONArray;
 var url,massage:string;
 var mas:array[0..6] of string[30];
begin
  TableClear(Sender,form14.StringGrid1);
    form14.StringGrid1.Cells[1,0]:= 'id заказа:';
    form14.StringGrid1.Cells[2,0]:= 'id курььера:';
    form14.StringGrid1.Cells[3,0]:= 'id оператора:';
    form14.StringGrid1.Cells[4,0]:= 'Время создания:';
    form14.StringGrid1.Cells[5,0]:= 'Время начала доставки:';
    form14.StringGrid1.Cells[6,0]:= 'Время окончания доставки:';
    form14.StringGrid1.Cells[7,0]:= 'Сумма:';
    form14.StringGrid1.Cells[8,0]:= 'Адресс:';
    JSON2:= ordersList(Sender);
    url:='/orders/list/';
    massage:=URLOut(Sender,url,JSON2.ToString());
    JSONA2:= TJSONObject.ParseJSONValue(massage) as TJSONArray;
    //Timer1.Enabled:=false;
    form14.StringGrid1.RowCount:= 20;
    form14.StringGrid1.ColCount:= 20;
    R:=1;
    for I := 0 to JSONA2.Size() - 1 do begin
     JSON2:=JSONA2[I] as TJSONObject;
     massage:=JSON2.Values['id'].Value;
     mas[0]:=JSON2.Values['courierid'].Value;
     mas[1]:=JSON2.Values['operatorid'].Value;
     mas[2]:=JSON2.Values['end_delivery_time'].Value;
     mas[3]:=JSON2.Values['start_delivery_time'].Value;
     mas[4]:=JSON2.Values['created_time'].Value;
     mas[5]:=JSON2.Values['total_summ'].Value;
     mas[6]:=JSON2.Values['delivery_address'].Value;
     //if id = '12' then ordersDelete(sender,id);
       if mas[2] <> '' then begin
       if form14.StringGrid1.RowCount = R  then form14.StringGrid1.ColCount:=form14.StringGrid1.ColCount + 1;
       form14.StringGrid1.RowHeights[R]:=100;
       form14.StringGrid1.ColWidths[1]:= 100;
       form14.StringGrid1.ColWidths[2]:= 100;
       form14.StringGrid1.ColWidths[3]:= 150;
       form14.StringGrid1.ColWidths[4]:= 150;
       form14.StringGrid1.ColWidths[5]:= 150;
       form14.StringGrid1.ColWidths[6]:= 250;
       form14.StringGrid1.ColWidths[7]:= 100;
       form14.StringGrid1.ColWidths[8]:= 250;
       form14.StringGrid1.Cells[1,R]:= 'id ' + massage;
       form14.StringGrid1.Cells[2,R]:= mas[0];
       form14.StringGrid1.Cells[3,R]:= mas[1];
       form14.StringGrid1.Cells[4,R]:= mas[4];
       form14.StringGrid1.Cells[5,R]:= mas[3];
       form14.StringGrid1.Cells[6,R]:= mas[2];
       form14.StringGrid1.Cells[7,R]:= mas[5];
       form14.StringGrid1.Cells[8,R]:= mas[6];
       R:=R+1;
       end;
    end;


end;

procedure TTestClientForm.MenuCouriers(Sender: TObject);
 var JSON1,JSON2:TJSONObject;
 var I,K,R,I1:integer;
 var JSONA1,JSONA2: TJSONArray;
 var url,massage,ab:string;
 var mas:array[0..5] of string[30];
begin
    TableClear(Sender,StringGrid1);
    TableClear(Sender,form8.StringGrid1);//таблица выбора.
    form8.StringGrid1.Cells[1,0]:= 'Курьеры'; //таблица выбора.
    StringGrid1.Cells[1,0]:= 'Курьеры';
    StringGrid1.Cells[2,0]:= 'Заказы курьеров:';
    JSON1:= couriersList(Sender);
    JSON2:= ordersList(Sender);
    url:='/couriers/list/';
    massage:=URLOut(Sender,url,JSON1.ToString());
    JSONA1:= TJSONObject.ParseJSONValue(massage) as TJSONArray;
    url:= '/orders/list/';
    //StringGrid1.Cells[2,3]:=';jgf';
    massage:=URLOut(Sender,url,JSON2.ToString());
    JSONA2:= TJSONObject.ParseJSONValue(massage) as TJSONArray;
    //Timer1.Enabled:=false;
    StringGrid1.RowCount:= 20;
    StringGrid1.ColCount:= 20;
    I:=1;
    for I := 0 to JSONA1.Size() - 1 do begin
      StringGrid1.RowHeights[I+1]:=100;
      StringGrid1.ColWidths[1]:= 250;
      if ab = '1' then begin
      form8.StringGrid1.RowHeights[I1+1]:=100;  //таблица выбора курьера
      form8.StringGrid1.ColWidths[1]:= 250;
      I1:=I1+1;
      end;  //таблица выбора курьера
      JSON1:= JSONA1[I] as TJSONObject;
      mas[0]:= JSON1.Values['id'].Value;
      mas[1]:= JSON1.Values['name'].Value;
      ab:=JSON1.Values['availability'].Value;
      R:=2;
      for K := 0 to JSONA2.Size() - 1 do begin
        JSON2:= JSONA2[K] as TJSONObject;
        mas[2]:= JSON2.Values['courierid'].value;
        mas[5]:=JSON2.Values['end_delivery_time'].Value;
        if (mas[2] = mas[0]) and (mas[5] = '') then begin
          if StringGrid1.ColCount = R  then StringGrid1.ColCount:=StringGrid1.ColCount + 1;
          StringGrid1.ColWidths[R]:= 150;
          mas[3]:=JSON2.Values['id'].value;
          mas[4]:=JSON2.Values['operatorid'].value;
          StringGrid1.Cells[R,I + 1]:='id ' + mas[3] + ' operator id ' +  mas[4];
          R:=R+1;
        end;
      end;
      if I + 1 = StringGrid1.RowCount then  StringGrid1.RowCount:= StringGrid1.RowCount + 1;
      if ab = '1' then form8.StringGrid1.Cells[1,I1+1]:= 'id ' + mas[0] + ' Имя ' +  mas[1];//таблица выбора курьера
      StringGrid1.Cells[1,I+1]:=' id ' + mas[0] + ' Имя ' +  mas[1];
    end;


    //if (form9.Add_operators) then begin operatorAdd(sender); form9.Add_operators:=false; end;
    //if (form9.OR_operators) then begin ordersOR(Sender,form9.id);form9.OR_operators := false; end;
    //RequestMemo.Lines.Add(form9.id);


end;

procedure TTestClientForm.MenuOperators(Sender: TObject);
var JSON:TJSONObject;
var I,R:integer;
var JSONA: TJSONArray;
var id,url,massage,massage1,massage2:string;
begin
    TableClear(Sender,form9.StringGrid1);
    form9.StringGrid1.ColWidths[1]:=250;
    form9.StringGrid1.Cells[1,0]:= 'Операторы';
    JSON:= operatorsList(Sender);
    url:= '/operators/list/' ;
    massage:=URLOut(Sender,url,JSON.toString());
    JSONA:= TJSONObject.ParseJSONValue(massage) as TJSONArray;
    R:=1;
    form9.StringGrid1.RowCount:= 20;
    form9.StringGrid1.ColCount := 20;
    for I := 0 to JSONA.Size() - 1 do begin
     JSON:=JSONA[I] as TJSONObject;
     id:=JSON.Values['id'].Value;
     massage1:=JSON.Values['name'].Value;
       if form9.StringGrid1.RowCount = R  then form9.StringGrid1.ColCount:=form9.StringGrid1.ColCount + 1;
       form9.StringGrid1.RowHeights[R]:=100;
       form9.StringGrid1.ColWidths[1]:= 250;
       form9.StringGrid1.Cells[1,R]:= 'id ' + id + ' Имя ' + massage1;
       R:=R+1;
    end;
    Timer1.Enabled:=false;
    if OperatorRun then begin Timer1.Enabled:=false; form9.Show(); end;
    if (form9.Add_operators) then begin
                                    Timer1.Enabled:=false;
                                    operatorAdd(sender);
                                    form9.Add_operators:=false;
                                    Timer1.Enabled:=true;
                                  end;
    if (form9.OR_operators) then begin
                                    Timer1.Enabled:=false;
                                    operatorOr(Sender,form9.id);
                                    form9.OR_operators := false;
                                    Timer1.Enabled:=true;
                                 end;
    OperatorRun:=false;
end;

procedure TTestClientForm.MenuProduct(Sender: Tobject);
var JSON:TJSONObject;
var I,R:integer;
var JSONA: TJSONArray;
var id,url,massage,massage1,massage2:string;
begin
    TableClear(Sender,form11.StringGrid1);
    form11.StringGrid1.ColWidths[1]:=250;
    form11.StringGrid1.ColWidths[2]:=250;
    form11.StringGrid1.ColWidths[3]:=250;
    form11.StringGrid1.Cells[1,0]:= 'ID товара';
    form11.StringGrid1.Cells[2,0]:= 'Имя';
    form11.StringGrid1.Cells[3,0]:= 'Цена';
    JSON:= operatorsList(Sender);
    url:= '/products/list/' ;
    massage:=URLOut(Sender,url,JSON.toString());
    JSONA:= TJSONObject.ParseJSONValue(massage) as TJSONArray;
    R:=1;
    form11.StringGrid1.RowCount:= 20;
    form11.StringGrid1.ColCount := 20;
    for I := 0 to JSONA.Size() - 1 do begin
     JSON:=JSONA[I] as TJSONObject;
     id:=JSON.Values['id'].Value;
     massage1:=JSON.Values['name'].Value;
     massage2:=JSON.Values['price'].Value;
       if form11.StringGrid1.RowCount = R  then form11.StringGrid1.ColCount:=form11.StringGrid1.ColCount + 1;
       form11.StringGrid1.RowHeights[R]:=100;
       form11.StringGrid1.ColWidths[1]:= 250;
       form11.StringGrid1.Cells[1,R]:= id;
       form11.StringGrid1.Cells[2,R]:= massage1;
       form11.StringGrid1.Cells[3,R]:= massage2;
       R:=R+1;
    end;
    //Timer1.Enabled:=false;
    if ProductRun then begin Timer1.Enabled:=false; form11.Show(); end;
    if (form11.Add_operators) then begin
                                    Timer1.Enabled:=false;
                                    productAdd(sender);
                                    form11.Add_operators:=false;
                                    Timer1.Enabled:=true;
                                  end;
    if (form11.OR_operators) then begin
                                    Timer1.Enabled:=false;
                                    ProductOr(Sender,form11.id);
                                    form11.OR_operators := false;
                                    Timer1.Enabled:=true;
                                 end;
    ProductRun:=false;

end;

procedure TTestClientForm.MenuOrders(Sender: TObject);
 var JSON:TJSONObject;
 var I,R:integer;
 var JSONA: TJSONArray;
 var id,url,massage,massage1,massage2:string;
begin
    TableClear(Sender,StringGrid2);
    StringGrid2.ColWidths[1]:=250;
    StringGrid2.Cells[1,0]:= 'Нераспределенные заказы';
    StringGrid2.Cells[2,0]:= 'Адрес';
    JSON:= ordersList(Sender);
    url:='/orders/list/';
    massage:=URLOut(Sender,url,JSON.ToString());
    JSONA:= TJSONObject.ParseJSONValue(massage) as TJSONArray;
    R:=1;
    StringGrid2.RowCount:= 20;
    StringGrid2.ColCount := 20;
    for I := 0 to JSONA.Size() - 1 do begin
     JSON:=JSONA[I] as TJSONObject;
     id:=JSON.Values['id'].Value;
     massage1:=JSON.Values['courierid'].Value;
     massage2:=JSON.Values['operatorid'].Value;
     //if id = '12' then ordersDelete(sender,id);
       if massage1 = '' then begin
       if StringGrid2.RowCount = R  then StringGrid2.ColCount:=StringGrid2.ColCount + 1;
       StringGrid2.RowHeights[R]:=100;
       StringGrid2.ColWidths[1]:= 250;
       StringGrid2.ColWidths[2]:= 250;
       StringGrid2.Cells[1,R]:= 'id ' + id + ' id оператора ' + massage2;
       massage1:=JSON.Values['delivery_address'].Value;
       StringGrid2.Cells[2,R]:= massage1;
       R:=R+1;
       end;
    end;
end;

procedure TTestClientForm.MenuOrdersInfo(Sender: TObject);
var JSON:TJSONObject;
 var I,R:integer;
 var JSONA: TJSONArray;
 var url,massage,id1,name,price,col:string;
begin
    TableClear(Sender,form10.StringGrid1);
    form10.StringGrid1.ColWidths[1]:=250;
    form10.StringGrid1.Cells[1,0]:= 'id';
    form10.StringGrid1.Cells[2,0]:= 'Имя';
    form10.StringGrid1.Cells[3,0]:= 'Цена';
    form10.StringGrid1.Cells[4,0]:= 'Количество';
    JSON:= ordersInfoList(Sender,OrdersIndoId);
    url:='/order-info/list/';
    massage:=URLOut(Sender,url,JSON.ToString());
    JSONA:= TJSONObject.ParseJSONValue(massage) as TJSONArray;
    R:=1;
    //JSON:=JSONA[0] as TJSONObject;
    form10.StringGrid1.RowCount:= 20;
    form10.StringGrid1.ColCount := 20;
    for I := 0 to JSONA.Size() - 1 do begin
     JSON:=JSONA[I] as TJSONObject;
     id1:=JSON.Values['id'].Value;
     name:=JSON.Values['name'].Value;
     price:=JSON.Values['price'].Value;
     col:=JSON.Values['count_'].Value;
     //if id = '12' then ordersDelete(sender,id);
       if form10.StringGrid1.RowCount = R  then form10.StringGrid1.ColCount:= form10.StringGrid1.ColCount + 1;
       form10.StringGrid1.RowHeights[R]:=100;
       form10.StringGrid1.ColWidths[1]:= 250;
       form10.StringGrid1.ColWidths[2]:= 250;
       form10.StringGrid1.ColWidths[3]:= 250;
       form10.StringGrid1.ColWidths[4]:= 250;
       form10.StringGrid1.Cells[1,R]:= ' ' + id1;
       form10.StringGrid1.Cells[2,R]:= ' ' + name;
       form10.StringGrid1.Cells[3,R]:= ' ' + price;
       form10.StringGrid1.Cells[4,R]:= ' ' + col;
       R:=R+1;

    end;
    if OrdersIngoRun then form10.show();
    if (form10.Add_operators) then begin
                                    Timer1.Enabled:=false;
                                    ordersInfoAdd(sender,OrdersIndoId);
                                    form10.Add_operators:=false;
                                    Timer1.Enabled:=true;
                                  end;
    if (form10.OR_operators) then begin
                                    Timer1.Enabled:=false;
                                    ordersInfoOr(Sender,form10.id);
                                    form10.OR_operators := false;
                                    Timer1.Enabled:=true;
                                 end;

    //operatorDelete(Sender,'6');
    OrdersIngoRun:=false;
end;

procedure TTestClientForm.MenuOrdersInfoRun(Sender: TObject);
begin
    OrdersIngoRun:=true;
end;


procedure TTestClientForm.MenuProductRun(Sender: TObject);
begin
   ProductRun:=true;
end;

procedure TTestClientForm.N1Click(Sender: TObject);
begin
    Timer1.Enabled:=true;
end;

procedure TTestClientForm.MenuOperatorRun(Sender: TObject);
begin
      OperatorRun:=true;

end;

{procedure TTestClientForm.N4Click(Sender: TObject);
begin

end;

procedure TTestClientForm.StringGrid1DrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var ST:integer;
var JSON:TJSONObject;
var I:integer;
var JSONA: TJSONArray;
var url,massage:string;
begin
    TableClear(Sender);
    StringGrid1.Cells[0,0]:= 'Курьеры';
    JSON:= couriersList(Sender);
    url:='/couriers/list/';
    massage:=URLOut(Sender,url,JSON.ToString());
    JSONA:= TJSONObject.ParseJSONValue(massage) as TJSONArray;


    for I := 0 to JSONA.Size() - 1 do begin
    JSON:=JSONA[I] as TJSONObject;
    url:=JSON.Values['availability'].Value;
    ST:=url.ToInteger();
    if (ST = 0) and (ACol = 0) and (ARow = I) then StringGrid1.Canvas.Brush.Color:=clRed;
    if (ST = 1) and (ACol = 0) and (ARow = I) then StringGrid1.Canvas.Brush.Color:=clGreen;
    StringGrid1.Canvas.FillRect(Rect);
    end;

end; }

//курьеры
function TTestClientForm.couriersId(Sender: TObject;id:string):TJSONObject;
var massage:string;
var JsonObject: TJSONObject;
begin
    JsonObject:= TJSONObject.Create;
    JsonObject.AddPair('id', id);
    couriersId:= JsonObject;
end;

procedure TTestClientForm.couriersAdd(Sender: TObject);
var url:string;
var massage:array[0..4] of string[30];
var JsonObject: TJSONObject;
begin
    Form1.ShowModal();
    massage[0]:= form1.edit1.text;
    massage[1]:= form1.edit2.text;
    massage[2]:= form1.edit3.text;
    massage[4]:='0';
    JsonObject:= TJSONObject.Create;
    JsonObject.AddPair('name', massage[0])
          .AddPair('availability',massage[4])
          .AddPair('login', massage[1])
          .AddPair('password',massage[2]);
    url:= '/couriers/add/';
    URLOut(Sender,url,JsonObject.ToString());
end;

procedure TTestClientForm.couriersDelete(Sender: TObject; id:String);
var url:string;
var JsonObject: TJSONObject;
begin
    JsonObject:= TJSONObject.Create;
    JsonObject.AddPair('id', id);
    url:= '/couriers/delete/';
    URLOut(Sender,url,JsonObject.ToString());
end;



function TTestClientForm.couriersList(Sender: TObject):TJSONObject;
var JsonObject: TJSONObject;
begin
    JsonObject:= TJSONObject.Create;
    //URLOut(Sender,url,JsonObject.ToString());
    couriersList:= JsonObject;
end;

procedure TTestClientForm.couriersOR(Sender: TObject;id:string);
var A,B,C:boolean;
begin
     Timer1.Enabled:=false;
     form6.RadioButton3.Visible:=false;
     form6.showModal();
     A:=form6.RadioButton1.Checked;
     B:=form6.RadioButton2.Checked;
     C:=form6.RadioButton3.Checked;
     if A and not(B) and not(C) then couriersDelete(Sender,id);
     if not(A) and B and not(C) then couriersUpdate(Sender,id);
     form6.RadioButton3.Visible:=true;
end;

procedure TTestClientForm.couriersUpdate(sender: Tobject;id:string);
var url:string;
var massage:array[0..4] of string[30];
var JsonObject: TJSONObject;
begin
    Form1.ShowModal();
    massage[0]:= form1.edit1.text;
    massage[1]:= form1.edit2.text;
    massage[2]:= form1.edit3.text;
    massage[4]:='0';
    JsonObject:= TJSONObject.Create;
    JsonObject.AddPair('id',id)
          .AddPair('name', massage[0])
          .AddPair('availability',massage[4])
          .AddPair('login', massage[1])
          .AddPair('password', massage[2])  ;
    url:= '/couriers/update/';
    URLOut(Sender,url,JsonObject.ToString());
end;





procedure TTestClientForm.FormCreate(Sender: TObject);
begin
OrdersIndoId:='0';
Timer1.Enabled:=true;
end;

procedure TTestClientForm.FormShow(Sender: TObject);
begin
end;

//операторы



procedure TTestClientForm.operatorAdd(Sender: TObject);
var url:string;
var massage:array[0..3] of string[30];
var JsonObject: TJSONObject;
begin
     form3.showModal();
     massage[0]:=form3.edit1.Text;
     massage[1]:=form3.edit2.Text;
     massage[2]:=form3.edit3.Text;
     JsonObject:= TJSONObject.Create;
     JsonObject.AddPair('name', massage[0])
          .AddPair('login', massage[1])
          .AddPair('password', massage[2]);
     url:='/operators/add/';
     URLOut(Sender,url,JsonObject.ToString());

end;

procedure TTestClientForm.openOrder(Sender: TObject);
var s:string;
begin
     form14.ShowModal();
end;

procedure TTestClientForm.operatorDelete(Sender: TObject;id:string);
var url:string;
var JsonObject: TJSONObject;
begin
    JsonObject:= TJSONObject.Create;
    JsonObject.AddPair('id', id);
    url:= '/operators/delete/';
    URLOut(Sender,url,JsonObject.ToString());
end;

function TTestClientForm.operatorId(Sender: TObject):TJSONObject;
var massage:string;
var JsonObject: TJSONObject;
begin
    form2.showModal();
    massage:= form2.edit1.text;
    JsonObject:= TJSONObject.Create;
    JsonObject.AddPair('id', massage);
    //URLOut(Sender,url,JsonObject.ToString());
    operatorId:=Jsonobject;
end;

procedure TTestClientForm.operatorOr(Sender: TObject; id:string);
var A,B,C:boolean;
begin
     form6.RadioButton3.Visible:=false;
     form6.showModal();
     A:=form6.RadioButton1.Checked;
     B:=form6.RadioButton2.Checked;
     C:=form6.RadioButton3.Checked;
     RequestMemo.Lines.Add(id);
     if A and not(B) and not(C) then operatorDelete(Sender,id);
     if not(A) and B and not(C) then operatorUpdate(Sender,id);
     form6.RadioButton3.Visible:=true;
end;

function TTestClientForm.operatorsList(sender: Tobject):TJSONObject;
var JsonObject: TJSONObject;
begin
    JsonObject:= TJSONObject.Create;
    //URLOut(Sender,url,JsonObject.ToString());
    operatorsList:=JsonObject;
end;

procedure TTestClientForm.operatorUpdate(Sender: TObject; id:string);
var url:string;
var massage:array[0..3] of string[30];
var JsonObject: TJSONObject;
begin
     form3.showModal();
     massage[0]:=form3.edit1.Text;
     massage[1]:=form3.edit2.Text;
     massage[2]:=form3.edit3.Text;
     JsonObject:= TJSONObject.Create;
     JsonObject.AddPair('id', id)
          .AddPair('name', massage[0])
          .AddPair('login', massage[1])
          .AddPair('password', massage[2]);
     url:='/operators/update/';
     URLOut(Sender,url,JsonObject.ToString());
end;


//orders

procedure TTestClientForm.ordersAdd(Sender: TObject);
var url:string;
var massage:array[0..3] of string[30];
var JsonObject: TJSONObject;
begin
      Timer1.Enabled:=false;
     form4.showModal();
     form8.showModal();
     massage[1]:=form8.id;
     //massage[2]:=form4.edit3.Text;
     massage[3]:=form4.edit4.Text;
     JsonObject:= TJSONObject.Create;
     JsonObject.AddPair('courierid', massage[1])
          .AddPair('operatorid', IDGlobal)
          //.AddPair('total_summ', massage[2])
          .AddPair('delivery_address',massage[3]);
     url:='/orders/add/';
     requestMemo.lines.add(JsonObject.values['operatorid'].value);
     requestMemo.lines.add(IDGlobal);
     //requestMemo.lines.add(JsonObject.ToString());
     URLOut(Sender,url,JsonObject.ToString());

end;

procedure TTestClientForm.ordersDelete(Sender: TObject;id:string);
var url:string;
var JsonObject:TJSONObject;
begin
    JsonObject:= TJSONObject.Create;
    JsonObject.AddPair('id', id);
    url:= '/orders/delete/';
    URLOut(Sender,url,JsonObject.ToString());
end;

function TTestClientForm.ordersId(Sender: TObject): TJSONObject;
var massage:string;
var JsonObject: TJSONObject;
begin
    form2.showModal();
    massage:= form2.edit1.text;
    JsonObject:= TJSONObject.Create;
    JsonObject.AddPair('id', massage);
    ordersId:= JsonObject;
end;



function TTestClientForm.ordersList(Sender: TObject):TJSONObject;
var JsonObject: TJSONObject;
begin
    JsonObject:= TJSONObject.Create;
    //URLOut(Sender,url,JsonObject.ToString());
    ordersList:=JsonObject;
end;


procedure TTestClientForm.ordersOR(Sender: TObject; id: string);
var A,B,C:boolean;
begin
     Timer1.Enabled:=false;
     form6.showModal();
     A:=form6.RadioButton1.Checked;
     B:=form6.RadioButton2.Checked;
     C:=form6.RadioButton3.Checked;
     if A and not(B) and not(C) then ordersDelete(Sender,id);
     if not(A) and B and not(C) then ordersUpdate(Sender,id);
     if not(A) and not(B) and C then  begin
                                      OrdersIndoId:=id;
                                      //requestMemo.lines.add(IDOrdersInfo);
                                      MenuOrdersInfoRun(Sender);
                                      end;

end;

procedure TTestClientForm.ordersUpdate(Sender: TObject;id:string);
var url:string;
var massage:array[0..4] of string[30];
var JsonObject: TJSONObject;
begin
     form4.showModal();
     form8.showModal();
     massage[1]:=form8.id;
     massage[3]:=form4.edit4.text;
     RequestMemo.Lines.Add(massage[1]);
     JsonObject:= TJSONObject.Create;
     JsonObject.AddPair('id', id)
          .AddPair('courierid', massage[1])
          .AddPair('operatorid', IDGlobal)
          .AddPair('delivery_address',massage[3]);
     url:='/orders/update/';
     URLOut(Sender,url,JsonObject.ToString());
end;

 //product

procedure TTestClientForm.productAdd(Sender:TObject);
var url:string;
var massage:array[0..4] of string[30];
var JsonObject: TJSONObject;
begin
    Timer1.Enabled:=false;
    form12.ShowModal();
    massage[0]:= form12.edit1.text;
    massage[1]:= form12.edit2.text;
    JsonObject:= TJSONObject.Create;
    JsonObject.AddPair('name', massage[0])
          .AddPair('price',massage[1]);
    url:= '/products/add/';
    URLOut(Sender,url,JsonObject.ToString());
end;

procedure TTestClientForm.productDelete(Sender: TObject; id: string);
var url:string;
var JsonObject: TJSONObject;
begin
    JsonObject:= TJSONObject.Create;
    JsonObject.AddPair('id', id);
    url:= '/products/delete/';
    URLOut(Sender,url,JsonObject.ToString());
end;

procedure TTestClientForm.ProductOr(Sender: TObject; id: string);
var A,B,C:boolean;
begin
    Timer1.Enabled:=false;
     form6.RadioButton3.Visible:=false;
     form6.showModal();
     A:=form6.RadioButton1.Checked;
     B:=form6.RadioButton2.Checked;
     C:=form6.RadioButton3.Checked;
     RequestMemo.Lines.Add(id);
     if A and not(B) and not(C) then productDelete(Sender,id);
     if not(A) and B and not(C) then productUpdate(Sender,id);
     form6.RadioButton3.Visible:=true;
end;

procedure TTestClientForm.productUpdate(Sender: TObject; id: string);
var url:string;
var massage:array[0..4] of string[30];
var JsonObject: TJSONObject;
begin
    Timer1.Enabled:=false;
    form12.ShowModal();
    massage[0]:= form12.edit1.text;
    massage[1]:= form12.edit2.text;
    JsonObject:= TJSONObject.Create;
    JsonObject.AddPair('id',id)
          .AddPair('name', massage[0])
          .AddPair('price',massage[1]);
    url:= '/products/update/';
    URLOut(Sender,url,JsonObject.ToString());
end;

// orders-info



procedure TTestClientForm.ordersInfoAdd(Sender: TObject;id:string);
var url:string;
var massage:array[0..3] of string[30];
var JsonObject:TJSONObject;
begin
   form11.New:=true;
   form11.showModal();
   form5.ShowModal();
   massage[1]:= form11.name;
   massage[2]:= form11.price;
   massage[3]:= form5.edit4.Text;
   JsonObject:= TJSONObject.Create;
   JsonObject.AddPair('order_id', id)
      .AddPair('name',massage[1])
      .AddPair('price',massage[2])
      .AddPair('count_',massage[3]);
   url:='/order-info/add/';
   URLOut(Sender,url,JsonObject.ToString());

end;

procedure TTestClientForm.ordersInfoDelete(Sender: TObject;id:string);
var url:string;
var JsonObject:TJSONObject;
begin
    JsonObject:= TJSONObject.Create;
    JsonObject.AddPair('id', id);
    url:= '/order-info/delete/';
    URLOut(Sender,url,JsonObject.ToString());
end;



function TTestClientForm.ordersInfoId(Sender: TObject;id:string): TJSONObject;
var JsonObject: TJSONObject;
var massage:string;
begin
    JsonObject:= TJSONObject.Create;
    JsonObject.AddPair('id', id);
    ordersInfoId:= JsonObject;
end;

function TTestClientForm.ordersInfoList(Sender: TObject;id:string): TJSONObject;
var JsonObject: TJSONObject;
begin
    JsonObject:= TJSONObject.Create;
    JsonObject.AddPair('order_id', id);
    ordersInfoList:= JsonObject;
end;

procedure TTestClientForm.ordersInfoOR(Sender: TObject; id: string);
var A,B,C:boolean;
begin
     form6.RadioButton3.Visible:=false;
     form6.showModal();
     A:=form6.RadioButton1.Checked;
     B:=form6.RadioButton2.Checked;
     C:=form6.RadioButton3.Checked;
     RequestMemo.Lines.Add(id);
     if A and not(B) and not(C) then ordersInfoDelete(Sender,id);
     if not(A) and B and not(C) then ordersInfoUpdate(Sender,id);
     form6.RadioButton3.Visible:=true;
end;

procedure TTestClientForm.ordersInfoUpdate(Sender: TObject; id: string);
var url:string;
var massage:array[0..4] of string[30];
var JsonObject: TJSONObject;
begin
   form5.ShowModal();
   massage[1]:= form11.name;
   massage[2]:= form11.price;
   massage[3]:= form5.edit4.Text;
   JsonObject:= TJSONObject.Create;
   JsonObject.AddPair('order_id',OrdersIndoId )
      .Addpair('id',id)
      .AddPair('name',massage[1])
      .AddPair('price',massage[2])
      .AddPair('count_',massage[3]);
   url:='/order-info/update/';
   URLOut(Sender,url,JsonObject.ToString());
end;

{procedure TTestClientForm.StringGrid1Click(Sender: TObject);

end;

{procedure TTestClientForm.StringGrid1DrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin

end;

procedure TTestClientForm.StringGrid1Click(Sender: TObject);
begin

end;

procedure TTestClientForm.N8Click(Sender: TObject);
begin

end;

procedure TTestClientForm.N7Click(Sender: TObject);
begin

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

  request := TStringStream.Create(UTF8Encode(RequestMemo.Lines.Text));

  try
    response := HTTP.Post(url, request);
  except
    ResponseMemo.Lines.Add('Не удалось подключится к серверу');
    exit;
  end;

  ResponseMemo.Lines.Text := '';
  ResponseMemo.Lines.Add(response);
end;  }

function TTestClientForm.URLOut(sender: TObject; url: string; massage:string):string;
var
  request : TStringStream;
  response : string;
  urlO:string;
begin
 //loginPassword(Sender);
  HTTP.Request.ContentType := 'application/json';
  HTTP.Request.CharSet := 'utf-8';

  urlO := 'http://' + form7.IPAdrees.text + url;

  request := TStringStream.Create(UTF8Encode(massage));

  try
    response := HTTP.Post(urlO, request);
  except

    ResponseMemo.Lines.Add('Не удалось подключится к серверу');
    exit;
  end;
  Timer1.Enabled:=true;
  ResponseMemo.Lines.Text := '';
  ResponseMemo.Lines.Add(response);
  URLout:=response;
   end;

//drag and drop
procedure TTestClientForm.RequestMemoDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var i : integer;
begin
RequestMemo.clear();
with StringGrid1 do
for i:= 0 to (ColCount - 1) do
begin
RequestMemo.Lines.Add(StringGrid1.Cells[0,i]);
 end;
end;


procedure TTestClientForm.RequestMemoDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
     Accept:= Source IS TStringGrid;
end;

procedure TTestClientForm.StringGrid1Click(Sender: TObject);
var I:integer;
begin
StringGrid1.BeginDrag(True);

end;

procedure TTestClientForm.StringGrid1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  var massage:string;
  var id:string;
  var ACol, ARow: integer;

  function mI(var s1:string):string;
  var a,i1:integer;
  var s:string;
  begin
  s:=s1;
  i1:=1;
  while s[i1]<>'И' do begin
     if s[i1] = 'd' then a:=i1+2;
     i1:=i1+1;
  end;
  s:=copy(s,a,i1-a);
  val(s,a,i1);
  str(a,s);
  mI:=s;
  end;

  function mIO(var s1:string):string;
  var a,i1:integer;
  var s:string;
  begin
  s:=s1;
  i1:=1;
  while (s[i1]<>'o') or (i1 < 2) do begin
     if s[i1] = 'd' then a:=i1+2;
     i1:=i1+1;
  end;
  s:=copy(s,a,i1-a);
  val(s,a,i1);
  str(a,s);
  mIO:=s;
  end;

begin
   StringGrid1.MouseToCell(X, Y, ACol, ARow);
   massage := StringGrid1.Cells[ACol,ARow];
   if Acol = 1 then if massage = '' then couriersAdd(sender) else begin id:= mI(massage);couriersOR(sender,id); end
   else begin id:= mIO(massage);OrdersOR(sender,id); end;

   Timer1.Enabled:=true;
   end;

procedure TTestClientForm.StringGrid2MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  var massage:string;
  var id:string;
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
   StringGrid2.MouseToCell(X, Y, ACol, ARow);
   massage := StringGrid2.Cells[ACol,ARow];
  //form8.showmodal();
   if Acol = 1 then if massage = '' then ordersAdd(sender) else begin id:= mI(massage);OrdersOR(sender,id); end
   else ;
   Timer1.Enabled:=true;
   //RequestMemo.Lines.Add(id);
   RequestMemo.Lines.Add(massage);
end;

{procedure TTestClientForm.Table2_2(Sender: TObject);
begin

end;

procedure TTestClientForm.Table2_1(Sender: TObject);
begin

end;

procedure TTestClientForm.StringGrid2MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin

end;

procedure TTestClientForm.StringGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
  var massage:string;
  var id:string;

  function mI(var s1:string):string;
  var a,i1:integer;
  var s:string;
  begin
  s:=s1;
  i1:=1;
  while s[i1]<>'И' do begin
     if s[i1] = 'd' then a:=i1+2;
     i1:=i1+1;
  end;
  s:=copy(s,a,i1-a);
  val(s,a,i1);
  str(a,s);
  mI:=s;
  end;


begin
   massage := StringGrid1.Cells[ACol,ARow];
   if Acol = 1 then if massage = '' then couriersAdd(sender) else begin id:= mI(massage);couriersOR(sender,id); end
   else ;

   RequestMemo.Lines.Add(id);
   RequestMemo.Lines.Add(massage);
   end;
       }
end.
