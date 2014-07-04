unit procfunc;
interface
  uses constvar,bmp,print,graph,crt,dos,gramouse,drivers;
  procedure initj;
  procedure init;
  function  ky(x1,y1,x2,y2:byte;flag:boolean):boolean;
  procedure rp;
  procedure delayt(ms:word);
  function  timer:real;
  procedure tis;
  function  finished:boolean;
  function  cl:boolean;
implementation
  function timer:real;
    var h,m,s,d:word;
  begin
    gettime(h,m,s,d);
    timer:=h*3600+m*60+s+d/100;
  end;
  procedure tis;
    var n:word;
  begin
    if pressed then dissign(x1,y1);pressed:=false;
    wx:=random(mx)+1;wy:=random(my)+1;
    for i:=1 to mx do for j:=1 to my do begin
     i2:=(i+wx) mod mx+1;j2:=(j+my) mod my+1;
     if a[i2,j2]<>0 then
     for k:=mx downto 1 do for l:=my downto 1 do
      if (i<>k) or (j<>l) then begin
     k2:=(k+wx) mod mx+1;l2:=(l+wy) mod my+1;
     if a[i2,j2]=a[k2,l2] then
     if ky(i2,j2,k2,l2,false) then begin
      signed:=true;
      tl:=tl-1;
      printxts;
      sign(i2,j2,10);
      sign(k2,l2,10);
      exit;
    end;end;end;
    write('');
  end;
  function  cl:boolean;
    var i,j,k,l:byte;
  begin
    for i:=1 to mx do for j:=1 to my do if a[i,j]<>0 then
      for k:=1 to mx do for l:=1 to my do if (i<>k) or (j<>l) then
        if a[i,j]=a[k,l] then if ky(i,j,k,l,false) then begin
          cl:=true;exit;
        end;
    cl:=false;
  end;
  procedure delayt(ms:word);
    var
      time0:real;
      event:tevent;
  begin
    time0:=timer;
    mouseshow(mousewhere.x,mousewhere.y);
    repeat
      getmouseevent(event);
      if event.what=4 then begin
        mousedisshow;
        mouseshow(mousewhere.x,mousewhere.y);
      end;
    until timer-time0>=ms/1000;
    mousedisshow;
  end;
  procedure init;
  begin
    sc:=0;xl:=4;tl:=6;u:=1;printxts;
    timeup:=false;
  end;
  function ky(x1,y1,x2,y2:byte;flag:boolean):boolean;
    const
      w:array [1..4,(x,y)] of shortint
       =((1,0),(0,1),(-1,0),(0,-1));
    procedure show;
      procedure showl(color:byte);
        var
          i,j:shortint;
      begin
        setcolor(color);
        for i:=-1 to mx+1 do
         for j:=-1 to my+1 do
         if c[i,j]=1 then begin
          if c[i+1,j]=1 then
            line(px+i*32+16,py+j*32+16,px+i*32+48,py+j*32+16);
          if c[i,j+1]=1 then
            line(px+i*32+16,py+j*32+16,px+i*32+16,py+j*32+48);
         end;
      end;
      var
        OldStyle: LineSettingsType;
        lt:word;
    begin
      lt:=random(65534)+1;
      GetLineSettings(OldStyle);
      SetLineStyle(4, lt, 3);   { New style }
      showl(12);delayt(250);showl(0);
      with OldStyle do          { Restore old line style }
        SetLineStyle(LineStyle, Pattern, Thickness);
    end;
    function kl(const x1,y1,x2,y2,t,g:shortint):boolean;
      var
        xn,yn:shortint;
        i,j,k:shortint;
      procedure dmark;
        var l:shortint;
      begin
        for l:=0 to j-k do
          c[x1+w[i,x]*l,y1+w[i,y]*l]:=1;
      end;
    begin
      kl:=t<>1; if t=1 then exit;
      for i:=1 to 4 do if ((w[i,y]<>w[g,y]) and (w[i,x]<>w[g,x])) or (g=5) then begin
        xn:=x1;yn:=y1;j:=0;
        repeat
          j:=j+1; xn:=x1+w[i,x]*j; yn:=y1+w[i,y]*j; k:=0;
        until not(xn in [0..mx+1]) or not(yn in [0..my+1]) or (a[xn,yn]<>0);
        if (xn=x2) and (yn=y2) then begin if flag then dmark; exit; end;
        xn:=x1;yn:=y1;
        for k:=j-1 downto 1 do begin
          xn:=xn+w[i,x]; yn:=yn+w[i,y];
          if kl(xn,yn,x2,y2,t-1,i) then begin
            if flag then dmark; exit;
          end;
        end;
      end;
      kl:=false;
    end;
  begin
    if not flag then ky:=kl(x1,y1,x2,y2,4,5) else begin
      flag:=true; fillchar(c,sizeof(c),0);
      if not kl(x1,y1,x2,y2,2,5) then
       if not kl(x1,y1,x2,y2,3,5) then
        if not kl(x1,y1,x2,y2,4,5) then ky:=false
        else show else show else show;
    end;
  end;
  procedure initj;
    var i,j,k,l,n:byte;
      t,p,m:byte;
  begin
    fillchar(a,sizeof(a),0);n:=0;l:=1;
    for i:=1 to mx do for j:=1 to my do begin
      l:=l+1;if l=2 then n:=n+1;l:=l mod 2;
      a[i,j]:=n mod mc+1;
    end;
    inc(xl);rp;
    timel:=300;
  end;
  procedure rp;
    type
      tb=array [1..mx*my] of byte;
    var
      b,c:tb;n:byte;
      i,j,k,l,h,nh,t,nt:byte;
  begin
    sound(1153);
    xl:=xl-1;printxts;
    n:=0;randomize;
    for i:=1 to mx do for j:=1 to my do
     if a[i,j]<>0 then begin
       n:=n+1;b[n]:=a[i,j];
     end;
    for l:=1 to 20 do begin
      j:=random(n)+1;
      for i:=1 to n do c[i]:=b[(j+i) mod n+1];
      h:=1;t:=n;k:=1;
      while k<=n do begin
        nh:=random(2)+1;nt:=random(2)+1;
        for i:=h to h+nh-1 do if k<=n then begin
          b[k]:=c[i];h:=h+1;k:=k+1;
        end;
        for i:=t downto t-nt+1 do if k<=n then begin
          b[k]:=c[i];t:=t-1;k:=k+1;
        end;
      end;
    end;
    for i:=1 to mx do for j:=1 to my do
     if a[i,j]<>0 then begin
      a[i,j]:=b[n];n:=n-1;
     end;
    sound(1044);
    printa;
    nosound;
  end;
  function finished:boolean;
    var i,j:byte;
  begin
    finished:=false;
    for i:=1 to mx do for j:=1 to my do begin
      if a[i,j]<>0 then exit;
    end;
    finished:=true;
  end;
end.