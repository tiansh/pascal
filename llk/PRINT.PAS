unit print;
interface
  uses graph,constvar,crt,dos,bmp;
  function IntToStr(i:longint):string;
  procedure printb(x,y:byte;n:byte);
  procedure printa;
  procedure sign   (x,y:byte;color:byte);
  procedure dissign(x,y:byte);
  procedure distory(x,y:byte);
  procedure printxts;
  procedure ptext(Str:string; x,y:word; color:byte; size:byte);
  procedure cls;
implementation
  function Exist(Path:string):boolean;
    var
      S: PathStr;
  begin
    S := FSearch(Path, GetEnv(''));
    Exist :=  S <> '';
  end;
  procedure ptext(Str:string; x,y:word; color:byte; size:byte);
  begin
    SetTextStyle(DefaultFont, HorizDir, Size);
    setcolor(color);
    outtextxy(x,y,str);
  end;
  procedure printxts;
  begin
    ptext('ллл',040,24,7,1);
    ptext('ллл',130,24,7,1);
    ptext('ллл',220,24,7,1);
    ptext('ллллллл',570,48,7,1);
    ptext(inttostr( u),040,24,12,1);
    ptext(inttostr(tl),130,24,12,1);
    ptext(inttostr(xl),220,24,12,1);
    ptext(inttostr(sc),570,48,12,1);
  end;
  function IntToStr(I : LongInt):String;
  { Convert any integer type to a string }
  var
   S: string[11];
  begin
   System.Str(I, S);
   IntToStr := S;
  end;
  procedure GraphIni;
    var Gd, Gm: Integer;
  begin
    Gd := Detect;
   InitGraph(Gd, Gm, ' ');
   if GraphResult <> grOk then
     Halt(1);
  end;
  procedure printb(x,y:byte;n:byte);
  begin
    distory(x,y);setcolor(15);if n<>0 then begin
      rectangle(px+x*bw,py+y*bw,px+x*bw+bw-1,py+y*bw+bw-1);
      if exist(tupian+'\'+biaomian+'\'+inttostr(n)+'.bmp')
       then bmp16(tupian+'\'+biaomian+'\'+inttostr(n)+'.bmp',px+x*bw+1,py+y*bw+1,16);
      moveto(px+x*bw+bw div 2-textwidth(#219)*trunc(ln(n)/ln(10))div 2-3,py+y*bw+3);outtext(inttostr(n));
    end;
  end;
  procedure fs(x,y:byte);
    var i,j:word;
  begin
    for i:=px+x*bw to px+x*bw+bw-1 do
      for j:=py+y*bw to py+y*bw+bw-1 do begin
        if getpixel(i,j) in [0,15] then putpixel(i,j,15-getpixel(i,j));
      end;
  end;
  procedure sign(x,y:byte;color:byte);
  begin
    distory(x,y); printb(x,y,a[x,y]);fs(x,y);
    setcolor(color);rectangle(px+x*bw,py+y*bw,px+x*bw+bw-1,py+y*bw+bw-1);
  end;
  procedure dissign(x,y:byte);
  begin
    distory(x,y); printb(x,y,a[x,y]);
    setcolor(15);rectangle(px+x*bw,py+y*bw,px+x*bw+bw-1,py+y*bw+bw-1);
  end;
  procedure distory(x,y:byte);
  var
    T: array[1..4] of PointType;
  begin
    t[1].x:=px+x*bw;     t[4].x:=t[1].x;
    t[1].y:=py+y*bw;     t[2].y:=t[1].y;
    t[3].x:=px+x*bw+bw-1;t[2].x:=t[3].x;
    t[3].y:=py+y*bw+bw  ;t[4].y:=t[3].y;
    SetFillStyle(1,0);setcolor(0);
    FillPoly(SizeOf(t) div SizeOf(PointType), T);
  end;
  procedure printa;
    var
     i,j:byte;
  begin
    for i:=1 to my do for j:=1 to mx do printb(j,i,a[j,i]);
  end;
  procedure cls;
  var
    T: array[1..4] of PointType;
  begin
    t[1].x:=0;      t[4].x:=t[1].x;
    t[1].y:=70;     t[2].y:=t[1].y;
    t[3].x:=getmaxx;t[2].x:=t[3].x;
    t[3].y:=getmaxy;t[4].y:=t[3].y;
    SetFillStyle(1,0);setcolor(0);
    FillPoly(SizeOf(t) div SizeOf(PointType), T);
  end;
begin
end.