unit print;
interface
  uses constant,bmp,graph,triangle,maths,music;
  function IntToStr(I: Longint): String;
  procedure printa(a:bd);
  procedure pq(a:bd;i,j:byte);
  procedure pw(x,y:word;color:byte);
  procedure pu;
  procedure pp;
  procedure ps;
  procedure pn(color:byte);
  procedure pn2(color:byte);
  procedure po(a:real;color:byte);
implementation
  function IntToStr;
  { Convert any integer type to a string }
  var
   S: string[11];
  begin
   Str(I, S);
   IntToStr := S;
  end;
  procedure pq;
  begin
    if (a[i,j]>0) and (not ((i=mx) and (j mod 2=0))) then
      bmp16(inttostr(a[i,j])+'.bmp',px+2*(i-1)*r+((j+1) mod 2)*r,py+round(sqrt(3)*(j-1+h)*r),0);
    if (a[i,j]=0) or ((i=mx) and (j mod 2=0)) then
      bmp16('0.bmp',px+2*(i-1)*r+((j+1) mod 2)*r,py+round(sqrt(3)*(j-1+h)*r),15);
    if (a[i,j]<0) and (not ((i=mx) and (j mod 2=0))) then
      bmp16(inttostr(a[i,j])+'.bmp',px+2*(i-1)*r+((j+1) mod 2)*r,py+round(sqrt(3)*(j-1+h)*r),13);
    dplay;
  end;
  procedure printa;
    var
      i,j:byte;
  begin
    for i:=1 to mx do
      for j:=1 to my-h do
        if (not ((i=mx) and (j mod 2=0))) then
          if (a[i,j]<>0) then pq(a,i,j) else bmp16('0.bmp',px+2*(i-1)*r+((j+1) mod 2)*r,py+round(sqrt(3)*(j-1+h)*r),15);
  end;
  procedure pw;
  begin
    bmp16(inttostr(color)+'.bmp',x-r,y-r,0);
  end;
  procedure pu;
  begin
    setcolor(10);
    line(px-1,py-1,px-1,py+round(sqrt(3)*(my-1)*r)+4*r+49-1+14);
    line(px-1,py-2,px+mx*r*2,py-2);
    line(px+mx*r*2,py-1,px+mx*r*2,py+round(sqrt(3)*(my-1)*r)+4*r+49-1+14);
    line(px-1,py+round(sqrt(3)*(my-1)*r)+4*r+49-1+14,px+mx*r*2-1,py+round(sqrt(3)*(my-1)*r)+4*r+49-1+14);
    line(px-1,py+round(sqrt(3)*(my-1)*r)+2*r,px+mx*r*2,py+round(sqrt(3)*(my-1)*r)+2*r);
    if (h<>0) or (h2>=maxq-1) then begin
      setcolor(14);
      if h2>=maxq-1 then setcolor(4);
      line(px-1,py-1+round(sqrt(3)*h*r),px+mx*r*2,py-1+round(sqrt(3)*h*r));
    end;dplay;
  end;
  procedure pp;
  begin
    bmp16('next.bmp',px+1,py+round(sqrt(3)*(my-1)*r)+4*r+14+2,16)
  end;
  procedure ps;
  begin
    bmp16('score.bmp',px,py-23,16);
  end;
  procedure pn(color:byte);
  begin
    bmp16(inttostr(color)+'.bmp',px+68,py+round(sqrt(3)*(my-1)*r)+4*r+8+14+4,0)
  end;
  procedure pn2;
  begin
    bmp16(inttostr(color)+'.bmp',px+mx*r-r,py+round(sqrt(3)*my*(r-1)+r*2.5),0)
  end;
  procedure po;
    var
      d1,d2,d:dot;
  begin
    setcolor(color);
    a:=abs(a-180);
    d.x:=px+mx*r-1;
    d.y:=py+round(sqrt(3)*my*(r-1)+3.5*r)-1;
    d1.x:=round(decsin(a)*r+d.x);
    d1.y:=round(deccos(a)*r+d.y);
    d2.x:=round(decsin(a)*3*r+d.x);
    d2.y:=round(deccos(a)*3*r+d.y);
    line(d1.x,d1.y,d2.x,d2.y);
    d1.x:=round(decsin(a-15)*(-20)+d2.x);
    d1.y:=round(deccos(a-15)*(-20)+d2.y);
    line(d1.x,d1.y,d2.x,d2.y);
    d1.x:=round(decsin(a+15)*(-20)+d2.x);
    d1.y:=round(deccos(a+15)*(-20)+d2.y);
    line(d1.x,d1.y,d2.x,d2.y);
    dplay;
  end;
end.