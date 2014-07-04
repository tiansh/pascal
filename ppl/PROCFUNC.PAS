unit ProcFunc;
interface
  uses Dos,CRT,Graph,
     Constant,Bmp,Print,Maths,Triangle,Score,FuncBall,Music;
  procedure Load(FileName:string;var a:bd);
  function  Next(a:bd):Byte;
  procedure MainInit(var a:bd);
  procedure Init(const a:bd;var n1,n2:Byte; var n:Real);
  function  Input(var a:Real;d:bd;n1,n2:Byte):Real;
  procedure bj(const a:bd;var b:bd);
  procedure v(var b,c:bd;x,y:Word;a:Real;Color:Byte);
  procedure q(var a:bd;x,y:Byte);
  procedure lu(a:bd;var n1,n2:Byte);
  function  go(var a:bd):Boolean;
  function  Finish(a:bd):Boolean;
implementation
  procedure Load;
    var
      FileInp:Text;
      i,j:Byte;
      c:Char;
  begin
    Assign(FileInp,FileName);
    Reset(FileInp);
    FillChar(a,SizeOf(a),0);
    for i:=1 to my+1 do begin
      for j:=1 to mx do begin
        Read(FileInp,c);
        case c of
          '0'..'8':a[j,i]:=Ord(c)-48;
          'F','f':a[j,i]:=-1;
          'E','e':a[j,i]:=-2;
          'W','w':begin
            Read(FileInp,c);
            a[j,i]:=-3;
            if c in ['r','R'] then w[j,i]:=random(maxcolor)+1 else w[j,i]:=Ord(c)-48;
          end;
          'R','r':a[j,i]:=random(maxcolor)+1;
        end;
      end;
      ReadLn(FileInp);
    end;
  end;
  function Next;
    var
      c:array [1..MaxColor] of Boolean;
      i,j:Byte;
  begin
    for i:=1 to MaxColor do c[i]:=False;
    for i:=1 to mx do
     for j:=1 to my-h do
     if a[i,j]>0 then c[a[i,j]]:=True;
    j:=0;
    for i:=1 to MaxColor do if c[i] then j:=j+1;
    j:=Random(j)+1;
    i:=1;
    while i<=j do begin
      if not c[i] then j:=j+1;
      i:=i+1;
    end;
    Next:=j;
  end;
  procedure lu;
  begin
    n2:=n1;
    n1:=Next(a);
  end;
  procedure MainInit;
    var i:Byte;
  begin
    Randomize;Scoren:='0';
    IniGraph;
    pu;pp;ps;
    FillChar(a,SizeOf(a),0);
    for i:=1 to mx do a[i,0]:=-1;
    RoundN:=1;
  end;
  procedure Init;
    var
      i:Word;
  begin
    h:=0;h2:=0;pu;
    po(n,0);n:=0;
    lu(a,n1,n2);lu(a,n1,n2);
    SetColor(0);
    for i:=py to py+Round(Sqrt(3)*(my-1)*r)+2*r-1 do
     line(px,i,px+mx*r*2-1,i);
    pn(n1);pn2(n2);
    pu;PrintA(a);
    po(0,NodeColor);
    PrintScore(Scoren);
    DPlay;
  end;
  function Input;
    var
      Time0,Time1,Time2:Real;
      b:Real;q,q2:Boolean;
      i,t,t2:Byte;
      e:Boolean;
      ix,iy:Word;
    procedure Pause;
    begin
      ClearDevice;
      PrintText('GAME PAUSED',162,202,3,8);
      PrintText('HIT "P" TO CONTINUE',142,242,2,8);
      PrintText('GAME PAUSED',160,200,3,4);
      PrintText('HIT "P" TO CONTINUE',140,240,2,4);
      repeat
        while not KeyPressed do DPlay;
        case ReadKey of
          #16{Crtl-P},#112{p},#80{P}:Break;
          #27{Esc}:begin CloseGraph; CloseFile; Halt; end;
          #0:case ReadKey of
            #107{Alt-F4},#45{Alt-X}:begin CloseGraph; CloseFile; Halt; end;
            #25{Crtl-P}:Break;
          end;
          #19{Crtl-S}:begin NoSound; Played:=not Played; end;
        end;
      until False;
      ClearDevice;DPlay;
      pu;pp;ps;
      pn(n1);pn2(n2);
      pu;PrintA(d);
      po(a,NodeColor);
      PrintScore(Scoren);
      PrintText(Chr(t+48),px+mx*r-r-20,py+Round(Sqrt(3)*my*(r-1)+r*2+50),2,4);
      Time1:=Timer-(MaxTime-t2);
      Time2:=Timer;
    end;
    procedure PrintTime;
    begin
      Time2:=Timer-Time1;
      t2:=t;
      t:=Trunc(MaxTime-Time2);
      if (t2<>t) then begin
        PrintText(#219#129#129{'ллл'},px+mx*r-r-20,py+Round(Sqrt(3)*my*(r-1)+r*2+49),2,0);
        PrintText(#219#129#129{'ллл'},px+mx*r-r-19,py+Round(Sqrt(3)*my*(r-1)+r*2+53),2,0);
        PrintText(IntToStr(2),px+mx*r-r-19,py+Round(Sqrt(3)*my*(r-1)+r*2+51),2,0);
        PrintText(IntToStr(2),px+mx*r-r-20,py+Round(Sqrt(3)*my*(r-1)+r*2+50),2,0);
        PrintText(IntToStr(t),px+mx*r-r-19,py+Round(Sqrt(3)*my*(r-1)+r*2+51),2,8);
        PrintText(IntToStr(t),px+mx*r-r-20,py+Round(Sqrt(3)*my*(r-1)+r*2+50),2,4);
      end;
      if Time2>MaxTime then begin
        e:=True;
      end;
      DPlay;
    end;
  begin
    SetColor(LightRed);
    ix:=px+2*(mx div 2-1)*r;iy:=py+Round(Sqrt(3)*(my-1)*r)+r;
    while KeyPressed do begin DPlay;ReadKey; end;
    po(a,NodeColor);
    pu;
    Time1:=Timer;Time0:=Timer;b:=a;e:=False;t:=MaxTime;
    PrintTime;
    repeat
      repeat PrintTime; until KeyPressed or e;
      q2:=Timer<Time0-0.1;
      q:=True;
      if not e then
       case ReadKey of
         #0:case ReadKey of
          #72{Up}:if Abs(a)<ed*(1+3*Ord(q2)) then a:=0 else a:=a-(a/Abs(a))*ed*(1+3*Ord(q2));
          #75{Left}:if a-ed*(1+3*Ord(q2))>MaxDec then a:=a-ed*(1+3*Ord(q2)) else a:=MaxDec;
          #77{Right}:if a+ed*(1+3*Ord(q2))<MinDec then a:=a+ed*(1+3*Ord(q2)) else a:=MinDec;
          #80{Down}:e:=True;
          #107{Alt-F4},#45{Alt-X}:begin CloseGraph; CloseFile; Halt; end;
          #25{Crtl-P}:begin Pause; Continue; end;
        end;
        #27{Esc}:begin CloseGraph; CloseFile; Halt; end;
        #13,#32{Enter,Space}:e:=True;
        #16{Crtl-P},#112{p},#80{P}:begin Pause; Continue; end;
        #19{Crtl-S},#115{s},#83{S}:begin NoSound; Played:=not Played; end;
        else q:=False;
      end;
      if q then Time0:=Timer;
      po(b,0);
      SetColor(10);line(px-1,py+Round(Sqrt(3)*(my-1)*r)+2*r,px+mx*r*2,py+Round(Sqrt(3)*(my-1)*r)+2*r);
      if d[mx div 2,my-h]<>0 then pq(d,mx div 2,my-h);
      if d[mx div 2-1,my-h]<>0 then pq(d,mx div 2-1,my-h);
      if d[mx div 2+1,my-h]<>0 then pq(d,mx div 2+1,my-h);
      po(a,NodeColor);
      b:=a;Input:=a;
    until e;
    PrintText(#219#129#129{'ллл'},px+mx*r-r-20,py+Round(Sqrt(3)*my*(r-1)+r*2+49),2,0);
    PrintText(#219#129#129{'ллл'},px+mx*r-r-19,py+Round(Sqrt(3)*my*(r-1)+r*2+53),2,0);
    PrintText(IntToStr(2),px+mx*r-r-19,py+Round(Sqrt(3)*my*(r-1)+r*2+51),2,0);
    PrintText(IntToStr(2),px+mx*r-r-20,py+Round(Sqrt(3)*my*(r-1)+r*2+50),2,0);
    h2:=h2+1;pu;
  end;
  procedure bj;
    var
      i,j:Byte;
  begin
    b:=a;
    for i:=1 to mx do
     for j:=1 to my+1-h do
     if b[i,j]=0 then
     if (not ((i=mx) and (j mod 2=0))) then
     if (a[i+1,j]<>0) or (a[i-1,j]<>0)
     or (a[i,j+1]<>0) or (a[i,j-1]<>0)
     or (a[i-((j mod 2)*2-1),j-1]<>0)
     or (a[i-((j mod 2)*2-1),j+1]<>0)
     or (j=1) then b[i,j]:=-1;
  end;
  procedure v;
    var
      d:Dot;
      n:Real;
      i:Word;
    function u(var d:Dot;var a:Real;n:Real;Color:Byte):Boolean;
      var
        dy,dl,dn:Dot;
        i:Word;
        Flag,fj:Boolean;
      function ch(var a,b:bd;d:Dot;Color:Byte):Boolean;
        var
          d2:Dot;
          i,j:Byte;
          Flag:Boolean;
          l:array [1..mx,1..my+1] of Real;
          MinX,MinY:Byte;MinL:Real;
      begin
        Flag:=False;
        for i:=1 to mx do
         for j:=1 to my+1-h do begin
          if (not ((i=mx) and (j mod 2=0))) then begin
            d2.x:=px+2*(i-1)*r+((j+1) mod 2)*r;
            d2.y:=py+Round(Sqrt(3)*(j-1+h)*r);
            l[i,j]:=dd(d,d2);
            if (l[i,j]<2*r) and (a[i,j]<>0) then Flag:=True;
          end;
        end;
        if d.y<=r+2*r*h+3 then Flag:=True;
        ch:=Flag;
        if Flag then begin
          MinX:=1;MinY:=1;MinL:=l[1,1];
          for i:=1 to mx do
           for j:=1 to my+1-h do
           if (not ((i=mx) and (j mod 2=0))) then
           if b[i,j]=-1 then
           if MinL>=l[i,j] then begin
            MinL:=l[i,j];MinX:=i;MinY:=j;
          end;
          a[MinX,MinY]:=Color;
          Bmp16('0.BMP',dl.x,dl.y,15);
          pq(a,MinX,MinY);
          q(a,MinX,MinY);
        end;
      end;
      function bi(var dy,dn:Dot;Color:Byte;var a:Real):Boolean;
        var Flag:Boolean;
      begin
        Flag:=(dn.x>=px+mx*r*2-2*r) or (dn.x<=px);bi:=Flag;
        if Flag then begin
          if dn.x<=px then d.x:=px else d.x:=px+mx*r*2-2*r;
          d.y:=dy.y-Round(Abs(d.x-dy.x)*DecCot(Abs(a)));
          Bmp16('0.BMP',dl.x,dl.y,15);
{          Bmp16(IntToStr(Color)+'.BMP',d.x,d.y,0);}
          a:=-a;
        end;
      end;
    begin
      dy:=d;dl:=d;dn:=d;i:=0;
      repeat
        Bmp16('0.BMP',dl.x,dl.y,15);
        Bmp16(IntToStr(Color)+'.BMP',dn.x,dn.y,0);
        dl:=dn; delay(8); i:=i+speed;
        dn.x:=dy.x+Round(i*DecSin(a));
        dn.y:=dy.y-Round(i*DecCos(a));
        SetColor(10);line(px-1,py+Round(Sqrt(3)*(my-1)*r)+2*r,px+mx*r*2,py+Round(Sqrt(3)*(my-1)*r)+2*r);
        po(n,NodeColor);
        Flag:=bi(dy,dn,Color,a);
        fj:=ch(b,c,dn,Color);
      until fj or Flag;
      u:=fj;
    end;
  begin
    d.x:=x;d.y:=y;n:=a;
    repeat until u(d,a,n,Color);
    if h2=Maxq then begin
      SetColor(0);
      for i:=py to py+Round(Sqrt(3)*(my)*r)+2*r-1 do
       line(px,i,px+mx*r*2-1,i);
      h2:=0;
      h:=h+1;
      pu;PrintA(b);
    end;
  end;
  procedure fall(var a:bd);
    var
      b:array [0..mx+1,0..my+2] of boolean;
      i,j,k,l,n:byte;
  begin
    fillchar(b,sizeof(b),false);
    for i:=1 to mx do if a[i,1]<>0 then b[i,1]:=true;
    repeat
      k:=0;
     for i:=1 to mx do
      for j:=1 to my+1 do
      if not (b[i,j]) and (a[i,j]<>0) then
       if (b[i+1,j]) or (b[i-1,j])
       or (b[i,j+1]) or (b[i,j-1])
       or (b[i-((j mod 2)*2-1),j-1])
       or (b[i-((j mod 2)*2-1),j+1]) then begin
         b[i,j]:=true;k:=k+1;l:=l+1;
       end;
    until k=0;
    for i:=1 to mx do
     for j:=my+1 downto 1 do
     if not b[i,j] and (a[i,j]<>0) then begin
       a[i,j]:=0;ls(10);pq(a,i,j)
     end;
  end;
  procedure q;
    const
      m:array [3..6] of Byte=(20,30,30,50);
    var
      b:array [0..mx+1,0..my+2] of Boolean;
      i,j,k,l,n:Byte;
  begin
    FillChar(b,SizeOf(b),False);
    b[x,y]:=True;
    k:=0;l:=1;
    repeat
      k:=0;
      for i:=1 to mx do
       for j:=1 to my+1-h do
       if not (b[i,j]) and (a[i,j]=a[x,y]) then
       if (b[i+1,j]) or (b[i-1,j])
       or (b[i,j+1]) or (b[i,j-1])
       or (b[i-((j mod 2)*2-1),j-1])
       or (b[i-((j mod 2)*2-1),j+1]) then begin
        b[i,j]:=True;k:=k+1;l:=l+1;
      end;
    until k=0;
    if l>6 then n:=m[6] else n:=m[l];
    if l>=3 then
     for i:=1 to mx do
     for j:=my+1-h downto 1 do
     if b[i,j] then begin
      a[i,j]:=0;
      Bmp16('0.bmp',px+2*(i-1)*r+((j+1) mod 2)*r,py+Round(Sqrt(3)*(j-1+h)*r),15);
    end;
    ls(l*n);DPlay;
    FuncB(a,x,y);
    fall(a);
  end;
  function go;
    var
      i,j:Byte;
      Flag,Quit:Boolean;
      r:Word;
  begin
    Flag:=False;
    for i:=1 to mx do if a[i,my+1-h]<>0 then Flag:=True;
    go:=Flag;
    if Flag then begin
      for i:=1 to mx+1 do
       for j:=1 to my-h+1 do
       if (a[i,j])<>0 then a[i,j]:=127;
      for i:=1 to mx do
       for j:=1 to my-h+1 do
       if (not ((i=mx) and (j mod 2=0))) then
       if (a[i,j]<>0) then pq(a,i,j);
      Delay(1000);
      ClearDevice;
      PrintText('  GAME OVER  ',161,201,3,8);
      PrintText('HIT "Crtl-R" TO CONTINUE',141,241,2,8);
      PrintText('  HIT "Alt-F4" TO EXIT  ',141,261,2,8);
      PrintText('  GAME OVER  ',160,200,3,4);
      PrintText('HIT "Crtl-R" TO CONTINUE',140,240,2,4);
      PrintText('  HIT "Alt-F4" TO EXIT  ',140,260,2,4);
      repeat
        while not KeyPressed do DPlay;
        Quit:=False;
        case ReadKey of
           #18{Crtl-R},#114{r},#82{R}:begin
            r:=RoundN;
            ClearDevice;DPlay;
            MainInit(a);DPlay;
            RoundN:=r-1;DPlay;
            Quit:=True;
          end;
          #27{Esc}:begin CloseGraph; CloseFile; Halt end;
          #0:case ReadKey of
            #107{Alt-F4},#45{Alt-X}:begin CloseGraph; CloseFile; Halt end;
            #19{Crtl-S},#115{s},#83{S}: begin
              r:=RoundN;
              ClearDevice;DPlay;
              MainInit(a);DPlay;
              RoundN:=r-1;DPlay;
              Quit:=True;
            end
           end
         end;
      until Quit;
    end;
    DPlay;
  end;
  function Finish;
    var
      i,j:Byte;
      Flag:Boolean;
  begin
    Flag:=True;
    for i:=1 to mx do
     for j:=1 to my do
     if a[i,j]>0
     then Flag:=False;
    Finish:=Flag;
    if Flag and Exist(Dir+IntToStr(RoundN+1)+Extension) then begin
      pu;Delays(1000);
      ClearDevice;
      PrintText('ROUND CLEAR',161,201,3,8);
      PrintText('ROUND CLEAR',160,200,3,4);
      if not ons then begin
        PrintText('Press any key to continue...',121,241,2,8);
        PrintText('Press any key to continue...',120,240,2,4);
      end else begin
        PrintText('Press any key to exit...',141,241,2,8);
        PrintText('Press any key to exit...',140,240,2,4);
      end;
      while not KeyPressed do DPlay;
      case ReadKey of
        #27{Esc}:begin CloseGraph; CloseFile; Halt end;
        #0:case ReadKey of
          #107{Alt-F4},#45{Alt-X}:begin CloseGraph; CloseFile; Halt end;
        end;
        #19{Crtl-S},#115{s},#83{S}:begin NoSound; Played:=not Played; end;
      end;
      ClearDevice;DPlay;pp;ps;pu;
    end;
    if Flag and not Exist(Dir+IntToStr(RoundN+1)+Extension) then begin
      pu;
      ClearDevice;
      PrintText('CONGRATULATIONS!',161,201,3,8);
      PrintText('You''ve finished all levels!',121,141,2,8);
      PrintText('HIT "Crtl-R" BACK TO 1#',141,261,2,8);
      PrintText('  HIT "Alt-F4" TO EXIT  ',141,281,2,8);
      PrintText('CONGRATULATIONS!',160,200,3,4);
      PrintText('You''ve finished all levels!',120,140,2,4);
      PrintText('HIT "Crtl-R" BACK TO 1#',140,260,2,4);
      PrintText('  HIT "Alt-F4" TO EXIT  ',140,280,2,4);
      repeat
        while not KeyPressed do DPlay;
        case ReadKey of
           #18{Crtl-R},#114{r},#82{R}:begin
            ClearDevice;
            MainInit(a);
            RoundN:=0;
            Break
           end;
          #27{Esc}:begin CloseGraph; CloseFile; Halt end;
          #0:case ReadKey of
            #107{Alt-F4},#45{Alt-X}:begin CloseGraph; CloseFile; Halt end;
            #19{Crtl-S},#115{s},#83{S}:begin
              ClearDevice;
              MainInit(a);
              RoundN:=0;
              Break
             end
           end
         end;
      until False;
    end;
  end;
end.
