unit print;
interface
  uses types, bmp, bmp2b, bmp16b, constant, graph, variable, crt;
  function  IntToStr(I: Longint): String;
  procedure printp(a:zhang;x,y:word;stand:byte;show:boolean);
  procedure printz;
  procedure printsx(color:byte);
  procedure printthr(a:zhang;n:byte);
  procedure printform(p,g,h,qx:boolean);
  procedure printb(a:zhang;n:byte;j:real;show:boolean);
  procedure printscore(color:byte);
  procedure clearb(n:byte);
implementation
  procedure clearb(n:byte);
    var
      i:byte;
    const
      color:array [1..4] of byte=(1,5,6,7);
  begin
    if nogradeb then exit;
    setfillstyle(1,2);
    case n of
      3{1}:bar(46,90,92,476);
      2{2}:bar(124,80,528,124);
      1{3}:bar(580,56,622,442);
      4{4}:bar(137,422,560,468);
    end;

  end;
  function IntToStr(I: Longint): String;
  { Convert any integer type to a string }
  var
   S: string[11];
  begin
   Str(I, S);
   IntToStr := S;
  end;

  procedure printp(a:zhang;x,y:word;stand:byte;show:boolean);
    var
      b:zhang;
  begin
    if nogradeb then exit;
    {Debug!}show:=show or cheat;{Debug!}
    b.lb:=lei(ord(a.lb) mod 4);b.sz:=a.sz;
    if a.lb>lei(11) then begin
      bmp16(tupian+'\'+wbt[lei(ord(bm.lb) mod 4)]+'\'+inttostr(bm.sz)+'.bmp',x,y,13,stand);
      bmp16(tupian+'\'+wbt[lei(ord( a.lb) mod 4)]+'\'+inttostr( a.sz)+'.bmp',x-12,y-2,13,stand)
    end else
    if a.lb>lei(7) then begin
      if samehuir(b) and not xiangg_ then
      bmp16(tupian+'\'+wbt[z]+'\--.bmp',x,y,0,stand)
      else
      bmp16(tupian+'\'+wbt[bm.lb]+'\'+inttostr(bm.sz)+'.bmp',x,y,13,stand)
    end else
    if show then begin
      bmp16(tupian+'\'+wbt[lei(ord( a.lb) mod 4)]+'\'+inttostr( a.sz)+'.bmp',x,y,13,stand);
      if samehuir(b) and not xiangg_ then bmp16(tupian+'\'+wbt[z]+'\-.bmp',x,y,0,stand);
      if a.lb>lei(3) then case stand of
        3{1}:begin
            bmp16(tupian+'\'+wbt[lei(ord( a.lb) mod 4)]+'\'+inttostr( a.sz)+'.bmp',x+2,y-12,13,stand);
            if samehuir(b) and not xiangg_ then bmp16(tupian+'\'+wbt[z]+'\-.bmp',x+2,y-12,0,stand);
          end;
        2{2}:begin
            bmp16(tupian+'\'+wbt[lei(ord( a.lb) mod 4)]+'\'+inttostr( a.sz)+'.bmp',x+12,y+2,13,stand);
            if samehuir(b) and not xiangg_ then bmp16(tupian+'\'+wbt[z]+'\-.bmp',x+12,y+2,0,stand);
          end;
        1{3}:begin
            bmp16(tupian+'\'+wbt[lei(ord( a.lb) mod 4)]+'\'+inttostr( a.sz)+'.bmp',x-2,y+12,13,stand);
            if samehuir(b) and not xiangg_ then bmp16(tupian+'\'+wbt[z]+'\-.bmp',x-2,y+12,0,stand);
          end;
        4{4}:begin
            bmp16(tupian+'\'+wbt[lei(ord( a.lb) mod 4)]+'\'+inttostr( a.sz)+'.bmp',x-12,y-2,13,stand);
            if samehuir(b) and not xiangg_ then bmp16(tupian+'\'+wbt[z]+'\-.bmp',x-12,y-2,0,stand);
          end;
      end
    end else begin
      bmp16(tupian+'\'+wbt[lei(ord(kb.lb) mod 4)]+'\'+inttostr(kb.sz)+'.bmp',x,y,13,stand)
    end
  end;

  procedure printb(a:zhang;n:byte;j:real;show:boolean);
    var
      x,y:real;
  begin
    if nogradeb then exit;
    x:=getmaxx;y:=getmaxy;
    case n of
      3{1}:begin x:=px+height; y:=getmaxy-(getmaxy+15*height) div 2 -(py-j*width-3*height); end;
      2{2}:begin x:=getmaxx-(getmaxx-15*width) div 2-(j-1)*width; y:=py+2*height; end;
      1{3}:begin x:=getmaxx-px-height; y:=(getmaxy+15*height) div 2 +(py-j*width-2*height); end;
      4{4}:begin x:=(getmaxx-15*width) div 2+(j-1)*width{}+5{}; y:=getmaxy-py-height; end;
    end;
    printp(a,round(x),round(y),n,show)
  end;
  procedure printz;
  begin
    bmp2(tupian+'\'+han+'\'+dnxb[(7{5}-dong) mod 4]+'.bmp',
     px+height-14+height,getmaxy-(getmaxy+15*height) div 2 -(py-(0)*width-3*height),15,1);
    bmp2(tupian+'\'+han+'\'+dnxb[(6{6}-dong) mod 4]+'.bmp',
     getmaxx-(getmaxx-15*width) div 2-((0)-1)*width-(-width+14),py+2*height-14+height,15,2);
    bmp2(tupian+'\'+han+'\'+dnxb[(5{7}-dong) mod 4]+'.bmp',
     getmaxx-px-height,(getmaxy+15*height) div 2 +(py-(0)*width-2*height)-(-width+14),15,3);
    bmp2(tupian+'\'+han+'\'+dnxb[(8{8}-dong) mod 4]+'.bmp',
     (getmaxx-15*width) div 2+((0)-1)*width{}+5{},getmaxy-py-height,15,4);
  end;
  procedure printscore(color:byte);
    procedure pnum(n:byte;x,y:word);
      const
        w:array [1..4,1..2] of shortint
         =((0,-8),(-8,0),(0,+8),(+8,0));
      var
        i:byte;
        s:string;
    begin
    if nogradeb then exit;
      str(score[n],s);
      for i:=1 to length(s) do
       bmp2(tupian+'\'+shu+'\'+s[i]+'.bmp',
        x+w[n,1]*(i-1-ord(length(s)=4)),y+w[n,2]*(i-1-ord(length(s)=4)),color,n-2*ord(n=3)+2*ord(n=1));
    end;
  begin
    if nogradeb then exit;
    pnum(3{1},
     px+height,getmaxy-(getmaxy+15*height) div 2 -(py-(0)*width-3*height)-7);
    pnum(2{2},
     getmaxx-(getmaxx-15*width) div 2-((0)-1)*width-(-width+14)+14,py+2*height);
    pnum(1{3},
     getmaxx-px-height-14+height,(getmaxy+15*height) div 2 +(py-(0)*width-2*height)-(-width+14)+14);
    pnum(4{4},
     (getmaxx-15*width) div 2+((0)-1)*width-7{}+5{},getmaxy-py-height-14+height);
  end;
  procedure printsx(color:byte);
    var
      i:byte;
      str:string;
  begin
    if nogradeb then begin
      if (color<>2) then begin
        textcolor(color-ord(color=15));
          if psx then begin write(sx:2); psx:=false end
          else if sx mod 10=0 then write(sx div 10) else
          if sx mod 2=0 then write('.');
      end
    end else begin
      str:=inttostr(sx);
      for i:=1 to length(str) do
       bmp2(tupian+'\'+shu+'\'+str[i]+'.bmp',242+ord(length(str)=1)*4+i*8,23,color,4);
    end;
  end;
  procedure printthr(a:zhang;n:byte);
    var
      x,y:word;
  begin
    if nogradeb then exit;
    x:=getmaxx;y:=getmaxy;
    case n of
      3{1}:begin x:=px+height+2*height+(thr[n] div 10)*height;
              y:=y-(y+15*height) div 2 -(py-(thr[n] mod 10 +3)*width-3*height); end;
      2{2}:begin x:=x-(x-15*width) div 2-((thr[n] mod 10 +3)-1)*width;
              y:=py+2*height+2*height+(thr[n] div 10)*height; end;
      1{3}:begin x:=x-px-height-2*height-(thr[n] div 10)*height;
              y:=(y+15*height) div 2 +(py-(thr[n] mod 10 +3)*width-2*height); end;
      4{4}:begin x:=(x-15*width) div 2+((thr[n] mod 10 +3)-1)*width{}+5{};
              y:=y-py-height-2*height-(thr[n] div 10)*height; end;
    end;
    printp(a,x,y,n,true);
  end;
  procedure printform(p,g,h,qx:boolean);
  begin
    if nogradeb then exit;
    setcolor(15);
    Rectangle(118,398,141,421);
    Rectangle(141,398,164,421);
    Rectangle(164,398,187,421);
    Rectangle(187,398,225,421);
    bmp2(tupian+'\'+han+'\p.bmp' ,118+ 5,398+ 4,8+7*ord(p <>false),4);
    bmp2(tupian+'\'+han+'\g.bmp' ,118+28,398+ 4,8+7*ord(g <>false),4);
    bmp2(tupian+'\'+han+'\u.bmp' ,118+51,398+ 4,8+7*ord(h <>false),4);
    bmp2(tupian+'\'+han+'\qx.bmp',118+74,398+ 4,8+7*ord(qx<>false),4);
  end;
end.
