unit print;
interface
  uses constvar,graph,crt;
  procedure printbd(x,y:word);
  procedure GraphIni;
  function IntToStr(I: Longint): String;
  procedure printt(s:string;color:byte;x,y:word);
  procedure gracls;
  procedure printa;
implementation
  procedure GraphIni;
    var Gd, Gm: Integer;
  begin
    Gd := Detect;
   InitGraph(Gd, Gm, ' ');
   if GraphResult <> grOk then
     Halt(1);
  end;
  function IntToStr(I: Longint): String;
  { Convert any integer type to a string }
  var
   S: string[11];
  begin
   Str(I, S);
   IntToStr := S;
  end;
  procedure printt;
    var j:word;
  begin
      setcolor(color);
      MoveTo(x,y);
      OutText(s);
  end;
  procedure printbd;
    var 
      i,j:word;
  begin
    setcolor(15);
    for i:=0 to 9 do for j:=0 to 9 do begin
      line(x+bw*i,y,x+bw*i,y+bw*9);
      line(x,y+bw*j,x+bw*9,y+bw*j);
    end;
    for i:=1 to 9 do begin
      printt(inttostr(i),15,x-15,y+i*bw-bw div 2);
      printt(chr(i+ord('A')-1),15,x+i*bw-bw div 2,y-15);
    end;
  end;

  procedure gracls;
  var
    T: array[1..4] of PointType;
  begin
    t[1].x:=0;      t[4].x:=0;
    t[1].y:=0;      t[2].y:=0;
    t[2].x:=getmaxx;t[3].x:=t[2].x;
    t[3].y:=getmaxy;t[4].y:=t[3].y;
    SetFillStyle(1,0);setcolor(0);
    FillPoly(SizeOf(t) div SizeOf(PointType), T);
  end;

  procedure printa;
    var
      i,j:byte;
  begin
    for i:=1 to 9 do for j:=1 to 9 do begin
      setcolor(a[i,j]*2);
      circle(px+(i-1)*bw+bw div 2,py+(j-1)*bw+bw div 2,bw div 2-4);
    end;
  end;
end.
