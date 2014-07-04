program heibq;
  uses crt,dos;
  const
    w:array [1..8,1..2] of shortint
     =(( 1, 1),( 1, 0),( 1,-1),
       ( 0, 1),        ( 0,-1),
       (-1, 1),(-1, 0),(-1,-1));
    path:pathstr='Save.sav';
    searchdeep=3;
  type
    ta=array [1..8,1..8] of shortint;
  var
    ca:array [1..8,1..8] of boolean;
    a:ta;
    px,py:byte;
    cp,pr,cr:shortint;
    pp,cc,tt:byte;
    c:char;
    flag1,flag2,op,loa,sou:boolean;
    f:text;
  procedure scrini;
  begin
    CheckBreak:=False;                   { turn off Contrl-C checking }
    TextMode(Lo(LastMode)+Font8x8);      { use 43 or 50 lines on EGA/VGA }
    TextBackground(Black);
    TextColor(White);
    Clrscr;                              { put message line on screen }
  end;
  procedure prn;
    var i:integer;
  begin
    writeln;
    textbackground(14);textcolor(0);
    writeln('                    ');
    writeln('   1 2 3 4 5 6 7 8  ');
    writeln('  '#218#196#194#196#194#196#194#196#194#196#194#196#194#196#194#196#191' ');
    for i:=1 to 7 do begin
      writeln(' ',i,#179#197#179#197#179#197#179#197#179#197#179#197#179#197#179#197#179' ');
      writeln('  '#195#196#197#196#197#196#197#196#197#196#197#196#197#196#197#196#180' ');
    end;
    writeln(' 8'#179#197#179#197#179#197#179#197#179#197#179#197#179#197#179#197#179' ');
    writeln('  '#192#196#193#196#193#196#193#196#193#196#193#196#193#196#193#196#217' ');
    writeln('                    ');
  end;
  procedure print(x,y:byte);
  begin
    gotoxy(2*x+2,2*y+3);
    if (x=px) and (y=py) then textbackground(5) else textbackground(14);
    if a[x,y]=1 then textcolor(0) else textcolor(7);
    if a[x,y]=0 then textcolor(10);
    if a[x,y]<>0 then write(#254) else begin
      if ca[x,y] then write(#250) else write(' ');
    end;
    gotoxy(1,1);
  end;
  function p_(q:shortint):byte;
    var
      i,j,t:integer;
  begin
    t:=0;
    for i:=1 to 8 do
     for j:=1 to 8 do
       if a[i,j]=q then t:=t+1;
    p_:=t;
  end;
  procedure inip;
    var
      i,j:byte;
  begin
    textcolor(7);textbackground(0);
    clrscr;
    gotoxy(1,1);
    if op then
     write('Player:',p_(pr):2,' Computer:',p_(cr):2)
     else
     write('Player1:',p_(pr):2,' Player2:',p_(cr):2);
    prn;
    for i:=1 to 8 do
     for j:=1 to 8 do
      print(i,j);
    gotoxy(1,1);
  end;
  procedure dg(s:string);
  begin
    gotoxy(1,22);
    textcolor(4);
    textbackground(0);
    write(s,' ':20-length(s));
  end;
  function Find(Path:string):boolean;
    var
      S: PathStr;
  begin
    S := FSearch(Path, GetEnv(''));
    if S = '' then Find := False else Find := True;
  end;
  procedure save(q:shortint);
    var
      x,y,n:integer;
  begin
    randomize;
    assign(f,path);
    rewrite(f);
    write(f,chr(ord(op)+ord(sou)*2+125));
    write(f,chr(160+(q+1)+(cr+1)*3));
    write(f,chr(130+px*8+py-1));
    for y:=1 to 8 do
     for x:=1 to 8 do begin
       n:=128+(a[x  ,y]+1)*27+(a[x+1,y]+1)*9
             +(a[x+2,y]+1)* 3+(a[x+3,y]+1);
       if n=160 then n:=251+random(5);
       write(f,chr(n));
       x:=x+3;
     end;
    for y:=1 to 8 do
     for x:=1 to 8 do begin
       n:=128+(a[y,x  ]+1)*27+(a[y,x+1]+1)*9
             +(a[y,x+2]+1)* 3+(a[y,x+3])+1;
       if n=160 then n:=251+random(5);
       write(f,chr(n));
       x:=x+3;
     end;
    close(f);
  end;
  procedure ini;
    var i,j:integer;
    function choose:boolean;
      var c:char;
    begin
      textcolor(4);
      writeln('1:  First');
      writeln('2:  Second');
      repeat
        c:=readkey;
        if c=#27 then halt;
      until c in ['1','2','s','f','S','F'];
      choose:=c in ['1','f','F'];
      textcolor(7);
      px:=1;py:=1;
      writeln;
    end;
    function pln:boolean;
      var c:char;
    begin
      textcolor(4);
      writeln('1:  1 player');
      writeln('2:  2 players');
      repeat
        c:=readkey;
        if c=#27 then halt;
      until c in ['1','2'];
      pln:=c='1';
      textcolor(7);
      px:=1;py:=1;
      writeln;
    end;
  begin
    tt:=0;
    for i:=1 to 8 do
     for j:=1 to 8 do
      a[i,j]:=0;
    op:=pln;
    if op then
      if choose then begin
        a[4,4]:=-1;a[5,5]:=-1;
        a[4,5]:= 1;a[5,4]:= 1;
        pr:=1;cr:=-1
      end else begin
        a[4,3]:= 1;a[4,4]:= 1;
        a[4,5]:= 1;a[5,4]:= 1;
        a[5,5]:=-1;
        px:=4;py:=3;
        pr:=-1;cr:=1
      end
    else begin
      a[4,4]:=-1;a[5,5]:=-1;
      a[4,5]:= 1;a[5,4]:= 1;
      pr:=1;cr:=-1
    end;
    loa:=true;
  end;
  procedure load;
    var
      i,j,n,q:integer;
      c:char;
  begin
    assign(f,path);
    reset(f);
    read(f,c);
    if not (ord(c) in [125..128]) then begin
       close(f);
       erase(f);
       ini;exit;
    end;
    op:=ord(c) in [126,128];
    sou:=ord(c) in [127,128];
    read(f,c);
    n:=ord(c)-160;
    if not (n in [0..8]) then begin
       close(f);
       erase(f);
       ini;exit;
    end;
    q:=n mod 3-1;
    cr:=n div 3-1;
    if q=cr then loa:=false else loa:=true;
    pr:=-cr;
    read(f,c);
    n:=ord(c)-130;
    py:=n mod 8+1;
    px:=n div 8;
    for i:=1 to 16 do begin
       read(f,c);
       n:=ord(c);
       if n>250 then n:=160;
       n:=n-128;
       for j:=3 downto 0 do begin
         a[((i-1) mod 2)*4+1+j,(i+1) div 2]:=n mod 3-1;
         n:=n div 3;
       end;
    end;
    for i:=1 to 16 do begin
       read(f,c);
       n:=ord(c);
       if n>250 then n:=160;
       n:=n-128;
       for j:=3 downto 0 do begin
         if a[(i+1) div 2,((i-1) mod 2)*4+1+j]<>n mod 3-1 then begin
           close(f);
           erase(f);
           ini;exit;
         end;
         n:=n div 3;
       end;
    end;
    close(f);
    if find(path) then erase(f);
  end;
  procedure init;
  begin
    scrini;sou:=true;
    if not find(path) then ini else load;
    inip;
  end;
  function turn(var a:ta;x,y:byte;q:shortint;f:boolean):byte;
    var
      i,t:integer;
    function tn(x,y:byte;n1,n2,q:shortint;f:boolean):byte;
      var
        t,i:integer;
    begin
      tn:=0;
      if not ((x+n1>8)or(x+n1<1)or(y+n2>8)or(y+n2<1)) then begin
        t:=0;
        if a[x+n1,y+n2]=-q then begin
          repeat
            x:=x+n1;
            y:=y+n2;
            t:=t+1;
            if (x+n1>8)or(x+n1<1)or(y+n2>8)or(y+n2<1) then begin
              t:=0;
              break;
            end;
          until a[x+n1,y+n2]<>-q;
          if not ((x+n1>8)or(x+n1<1)or(y+n2>8)or(y+n2<1)) then
            if a[x+n1,y+n2]<>q then t:=0;
          tn:=t;
        end;
        if (t<>0) and f then
          for i:=0 to t-1 do a[x-i*n1,y-i*n2]:=-a[x-i*n1,y-i*n2];
      end;
    end;
  begin
    t:=0;
    for i:=1 to 8 do t:=t+tn(x,y,w[i,1],w[i,2],q,f);
    turn:=t*ord(a[x,y]=0);
  end;
  procedure p;
    var
      c:char;
    function err(a:ta;q:shortint):boolean;
      var
        x,y,t:integer;
    begin
      t:=0;
      for x:=1 to 8 do
       for y:=1 to 8 do
        t:=t+turn(a,x,y,q,false);
      err:=t=0;
    end;
    function num(a:ta;q:shortint):byte;
      var
        n,i,j:byte;
    begin
      n:=0;
      for i:=1 to 8 do for j:=1 to 8 do if a[i,j]=q then inc(n);
      num:=n;
    end;
    function de(a:ta;var x,y:byte;q:shortint;times:byte):longint;
      var
        i,j,k:integer;
        max,n:longint;
        bd,bb:ta;
        bds:array [1..8,1..8] of longint;
        bdb,bdbb:array [1..8,1..8] of boolean;
        xx,yy:byte;
        fla:boolean;
        ttt,tts:byte;
        top5:array [1..5] of longint;top:longint;
      procedure swap(var a,b:longint);var temp:longint; begin temp:=a;a:=b;b:=temp; end;
      function qk(a:ta;x,y:byte;q:shortint):boolean;
        var
          b:ta;
          i,j:integer;
          f:boolean;
      begin
        f:=false;qk:=false;
        for i:=1 to 8 do
         for j:=1 to 8 do begin
           b:=a;
           turn(b,i,j,q,true);
           if b[x,y]=q then qk:=true;
         end;
      end;
    begin
      randomize;
      n:=150000*(ord(a[1,1]=q)*2-1)+150000*(ord(a[1,8]=q)*2-1)
        +150000*(ord(a[8,1]=q)*2-1)+150000*(ord(a[8,8]=q)*2-1);
      for i:=1 to 8 do
       for j:=1 to 8 do begin
         bds[i,j]:=10*turn(a,i,j,q,false);
         bdb[i,j]:=(bds[i,j]<>0) and (a[i,j]=0);
         if tt>=58 then bds[i,j]:=bds[i,j]*8000;
         bds[i,j]:=bds[i,j]+random(10)+n;
       end;
      for i:=1 to 8 do
       for j:=1 to 8 do
       if bdb[i,j] then begin
         bd:=a;turn(bd,i,j,q,true);bd[i,j]:=q;
         if (a[2,2]<>q) and (bd[2,2]=q) then bds[i,j]:=bds[i,j]-1000000;
         if (a[7,7]<>q) and (bd[7,7]=q) then bds[i,j]:=bds[i,j]-1000000;
         if (a[2,7]<>q) and (bd[2,7]=q) then bds[i,j]:=bds[i,j]-1000000;
         if (a[7,2]<>q) and (bd[7,2]=q) then bds[i,j]:=bds[i,j]-1000000;
         if  (turn(bd,1,1,-q,false)<>0)or(turn(bd,8,1,-q,false)<>0)
           or(turn(bd,8,8,-q,false)<>0)or(turn(bd,1,8,-q,false)<>0)
           then bds[i,j]:=bds[i,j]-200000000;
         if err(bd,-q) then bds[i,j]:=bds[i,j]+15000;
         if err(bd,-q) and err(bd,q) then bds[i,j]:=1500000000*(ord(num(bd,q)>num(bd,-q))*2-1);
         if num(bd,q)+num(bd,-q)<16 then begin
           fla:=true;
           for xx:=3 to 6 do
            for yy:=3 to 6 do begin
              fla:=fla and (turn(bd,xx,yy,-q,false)=0);
            end;
           if fla then bds[i,j]:=bds[i,j]+80000;
        end;
        if (i in [1,8]) or (j in [1,8]) then
         if qk(bd,i,j,-q) then bds[i,j]:=bds[i,j]-8000000
         else else if qk(bd,i,j,-q) then bds[i,j]:=bds[i,j]-160000;
        if i in [1,8] then if j in [2..7] then begin
          if (bd[i,j+1] =bd[i,j-1]) and (bd[i,j+1]<>0) then bds[i,j]:=bds[i,j]+25000000;
          if (bd[i,j+1]<>bd[i,j-1]) and (bd[i,j+1]<>0) and (bd[i,j-1]<>0) then bds[i,j]:=bds[i,j]-80000000;
        end;
        if i in [2..7] then if j in [1,8] then begin
          if (bd[i+1,j] =bd[i-1,j]) and (bd[i+1,j]<>0) then bds[i,j]:=bds[i,j]+25000000;
          if (bd[i+1,j]<>bd[i-1,j]) and (bd[i+1,j]<>0) and (bd[i-1,j]<>0) then bds[i,j]:=bds[i,j]-80000000;
        end;
      end;
      i:=8;while (a[1,i]=q) and (i in [1..8]) do begin dec(i);if i in [1..8] then if a[1,i]=q then inc(bds[1,i],90000000); end;
      i:=8;while (a[i,1]=q) and (i in [1..8]) do begin dec(i);if i in [1..8] then if a[i,1]=q then inc(bds[i,1],90000000); end;
      i:=8;while (a[8,i]=q) and (i in [1..8]) do begin dec(i);if i in [1..8] then if a[8,i]=q then inc(bds[8,i],90000000); end;
      i:=8;while (a[i,8]=q) and (i in [1..8]) do begin dec(i);if i in [1..8] then if a[i,8]=q then inc(bds[i,8],90000000); end;
      i:=1;while (a[1,i]=q) and (i in [1..8]) do begin inc(i);if i in [1..8] then if a[1,i]=q then inc(bds[1,i],90000000); end;
      i:=1;while (a[i,1]=q) and (i in [1..8]) do begin inc(i);if i in [1..8] then if a[i,1]=q then inc(bds[i,1],90000000); end;
      i:=1;while (a[8,i]=q) and (i in [1..8]) do begin inc(i);if i in [1..8] then if a[8,i]=q then inc(bds[8,i],90000000); end;
      i:=1;while (a[i,8]=q) and (i in [1..8]) do begin inc(i);if i in [1..8] then if a[i,8]=q then inc(bds[i,8],90000000); end;
      bds[2,1]:=bds[2,1]-30000;bds[2,8]:=bds[2,8]-30000;
      bds[1,2]:=bds[1,2]-30000;bds[8,2]:=bds[8,2]-30000;
      bds[7,1]:=bds[7,1]-30000;bds[7,8]:=bds[7,8]-30000;
      bds[1,7]:=bds[1,7]-30000;bds[8,7]:=bds[8,7]-30000;
      bds[3,3]:=bds[3,3]+5000;bds[3,6]:=bds[3,6]+5000;bds[6,3]:=bds[6,3]+5000;bds[6,6]:=bds[6,6]+5000;
      for i:=1 to 8 do begin
        bds[1,i]:=bds[1,i]+700000;
        bds[8,i]:=bds[8,i]+700000;
        bds[i,1]:=bds[i,1]+700000;
        bds[i,8]:=bds[i,8]+700000;
      end;
      bds[1,1]:=bds[1,1]+3000000; bds[1,8]:=bds[1,8]+3000000;
      bds[8,1]:=bds[8,1]+3000000; bds[8,8]:=bds[8,8]+3000000;
      bds[2,2]:=bds[2,2]-2000000; bds[2,7]:=bds[2,7]-2000000;
      bds[7,2]:=bds[7,2]-2000000; bds[7,7]:=bds[7,7]-2000000;
      for i:=2 to 7 do begin
        bds[2,i]:=bds[2,i]-250000*ord((a[1,i]=0)or(a[1,i+1]=0)or(a[1,i-1]=0));
        bds[7,i]:=bds[7,i]-250000*ord((a[8,i]=0)or(a[8,i+1]=0)or(a[8,i-1]=0));
        bds[i,2]:=bds[i,2]-250000*ord((a[i,1]=0)or(a[i+1,1]=0)or(a[i-1,1]=0));
        bds[i,7]:=bds[i,2]-250000*ord((a[i,8]=0)or(a[i+1,8]=0)or(a[i-1,8]=0));
      end;
      for i:=3 to 8 do begin
        if (a[1,i-1]=0) then bds[1,i]:=bds[1,i]-2700000*ord(a[1,i-2]= q);
        if (a[8,i-1]=0) then bds[8,i]:=bds[8,i]-2700000*ord(a[8,i-2]= q);
        if (a[i-1,1]=0) then bds[i,1]:=bds[i,1]-2700000*ord(a[i-2,1]= q);
        if (a[i-1,8]=0) then bds[i,8]:=bds[i,8]-2700000*ord(a[i-2,8]= q);
        if (a[1,i-1]=0) then bds[1,i]:=bds[1,i]+2700000*ord(a[1,i-2]=-q);
        if (a[8,i-1]=0) then bds[8,i]:=bds[8,i]+2700000*ord(a[8,i-2]=-q);
        if (a[i-1,1]=0) then bds[i,1]:=bds[i,1]+2700000*ord(a[i-2,1]=-q);
        if (a[i-1,8]=0) then bds[i,8]:=bds[i,8]+2700000*ord(a[i-2,8]=-q);
      end;
      for i:=1 to 6 do begin
        if (a[1,i+1]=0) then bds[1,i]:=bds[1,i]-4700000*ord(a[1,i+2]= q);
        if (a[8,i+1]=0) then bds[8,i]:=bds[8,i]-4700000*ord(a[8,i+2]= q);
        if (a[i+1,1]=0) then bds[i,1]:=bds[i,1]-4700000*ord(a[i+2,1]= q);
        if (a[i+1,8]=0) then bds[i,8]:=bds[i,8]-4700000*ord(a[i+2,8]= q);
        if (a[1,i+1]=0) then bds[1,i]:=bds[1,i]+2700000*ord(a[1,i+2]=-q);
        if (a[8,i+1]=0) then bds[8,i]:=bds[8,i]+2700000*ord(a[8,i+2]=-q);
        if (a[i+1,1]=0) then bds[i,1]:=bds[i,1]+2700000*ord(a[i+2,1]=-q);
        if (a[i+1,8]=0) then bds[i,8]:=bds[i,8]+2700000*ord(a[i+2,8]=-q);
      end;
      for i:=1 to 4 do begin
        if (a[1,i+1]=0) and (a[1,i+2]=0) then bds[1,i]:=bds[1,i]-700000*ord(a[1,i+3]=-q);
        if (a[8,i+1]=0) and (a[8,i+2]=0) then bds[8,i]:=bds[8,i]-700000*ord(a[8,i+3]=-q);
        if (a[i+1,1]=0) and (a[i+2,1]=0) then bds[i,1]:=bds[i,1]-700000*ord(a[i+3,1]=-q);
        if (a[i+1,8]=0) and (a[i+2,8]=0) then bds[i,8]:=bds[i,8]-700000*ord(a[i+3,8]=-q);
        if (a[1,i+1]=0) and (a[1,i+2]=0) then bds[1,i]:=bds[1,i]+700000*ord(a[1,i+3]= q);
        if (a[8,i+1]=0) and (a[8,i+2]=0) then bds[8,i]:=bds[8,i]+700000*ord(a[8,i+3]= q);
        if (a[i+1,1]=0) and (a[i+2,1]=0) then bds[i,1]:=bds[i,1]+700000*ord(a[i+3,1]= q);
        if (a[i+1,8]=0) and (a[i+2,8]=0) then bds[i,8]:=bds[i,8]+700000*ord(a[i+3,8]= q);
      end;
      for i:=5 to 8 do begin
        if (a[1,i-1]=0) and (a[1,i-2]=0) then bds[1,i]:=bds[1,i]-700000*ord(a[1,i-3]=-q);
        if (a[8,i-1]=0) and (a[8,i-2]=0) then bds[8,i]:=bds[8,i]-700000*ord(a[8,i-3]=-q);
        if (a[i-1,1]=0) and (a[i-2,1]=0) then bds[i,1]:=bds[i,1]-700000*ord(a[i-3,1]=-q);
        if (a[i-1,8]=0) and (a[i-2,8]=0) then bds[i,8]:=bds[i,8]-700000*ord(a[i-3,8]=-q);
        if (a[1,i-1]=0) and (a[1,i-2]=0) then bds[1,i]:=bds[1,i]+700000*ord(a[1,i-3]= q);
        if (a[8,i-1]=0) and (a[8,i-2]=0) then bds[8,i]:=bds[8,i]+700000*ord(a[8,i-3]= q);
        if (a[i-1,1]=0) and (a[i-2,1]=0) then bds[i,1]:=bds[i,1]+700000*ord(a[i-3,1]= q);
        if (a[i-1,8]=0) and (a[i-2,8]=0) then bds[i,8]:=bds[i,8]+700000*ord(a[i-3,8]= q);
      end;
      k:=1;for i:=1 to 8 do for j:=1 to 8 do if bdb[i,j] then begin
        if k<6 then top5[k]:=bds[i,j];k:=k+1;
      end;
      for i:=1 to 8 do for j:=1 to 8 do if bdb[i,j] then begin
        top:=bds[i,j];for k:=1 to 5 do if top>top5[k] then swap(top,top5[k]);
      end;
      for i:=1 to 8 do for j:=1 to 8 do bdbb[i,j]:=bdb[i,j] and (bds[i,j]>=top5[5]);
      if times<>0 then for i:=1 to 8 do for j:=1 to 8 do if bdbb[i,j] then begin
        bd:=a;turn(bd,i,j,q,true);bd[i,j]:=q;
        if not err(bd,-q) then bds[i,j]:=bds[i,j]-de(bd,ttt,tts,-q,times-1)div 46;
      end;
      max:=maxlongint;
      for i:=1 to 8 do
       for j:=1 to 8 do
        if bdbb[i,j] then max:=bds[i,j];
      if max=maxlongint then
      for i:=1 to 8 do
       for j:=1 to 8 do
        if bdb[i,j] then max:=bds[i,j];
      for i:=1 to 8 do
       for j:=1 to 8 do
        if (bds[i,j]>=max) and (bdb[i,j]) then begin
          x:=i;y:=j;max:=bds[i,j];
        end;
      de:=max;
    end;
    procedure input(var px,py:byte;var q:shortint);
      var
        c:char;
        x,y:byte;
    begin
      for x:=1 to 8 do for y:=1 to 8 do ca[x,y]:=turn(a,x,y,q,false)<>0;
      for x:=1 to 8 do for y:=1 to 8 do print(x,y);
      repeat
        while keypressed do c:=readkey;
        c:=readkey;
        x:=px;y:=py;
        case c of
          #0:case readkey of
            #75:if Px<>1 then Px:=Px-1 else if sou then write('');
            #72:if Py<>1 then Py:=Py-1 else if sou then write('');
            #80:if Py<>8 then Py:=Py+1 else if sou then write('');
            #77:if Px<>8 then Px:=Px+1 else if sou then write('');
          end;
          '':sou:=not sou;
          '':de(a,px,py,q,0);
          '':begin
                scrini;ini;
                for x:=1 to 8 do
                 for y:=1 to 8 do
                  ca[x,y]:=turn(a,x,y,q,false)<>0;
	        inip;save(q);
              end;
          #27:begin save(q);halt;end;
        end;
        print(x,y);print(px,py);
      until (c=#13) and (a[px,py]=0);
      for x:=1 to 8 do
       for y:=1 to 8 do
        ca[x,y]:=false;
    end;
  begin
    flag1:=true;flag2:=true;
    repeat
      if not err(a,pr) and loa then begin
        repeat
          input(px,py,pr);
        until turn(a,px,py,pr,true)<>0;
        a[px,py]:=pr;tt:=tt+1;
        inip;flag1:=true;
      end else if err(a,pr) then begin
        if op then dg('Player couldn''t play!')
          else dg('Player 1 couldn''t play!');
        if sou then sound(1044);delay(500);nosound;
        flag1:=false;
      end;
      if not flag1 and not flag2 then break;
      if not err(a,cr) then begin
        if op then begin
          de(a,px,py,cr,searchdeep);
          inip;delay(500);
        end else begin
          repeat
            input(px,py,cr);
          until turn(a,px,py,cr,true)<>0;
        end;
        a[px,py]:=cr;tt:=tt+1;
        turn(a,px,py,cr,true);
        inip;flag2:=true;
      end else begin
        if op then dg('Computer couldn''t play')
          else dg('Player 2 couldn''t play!');
        if sou then sound(1044);delay(500);nosound;
        flag2:=false;
      end;
      loa:=true;
    until not flag1 and not flag2;
  end;
  procedure r;
  begin
    inip;
    gotoxy(1,22);
    textcolor(20);
    textbackground(0);
    if (p_(cr)>p_(pr)) and op then begin
      writeln('Computer has won!');
    end;
    if (p_(cr)<p_(pr)) and op then begin
      writeln('You have won!');
    end;
    if (p_(cr)>p_(pr)) and not op then writeln('Player 2 has won!');
    if (p_(cr)<p_(pr)) and not op then writeln('Player 1 have won!');
    if (p_(cr)=p_(pr)) then writeln('We drew!');
    writeln('Enter  :  Continue');
    writeln('Esc    :      Exit');
    repeat c:=readkey; until c in [#13,#27];
  end;
begin
  repeat
    init;p;r;
  until c=#27;
end.
