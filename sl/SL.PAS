program sl;
  uses CRT,DOS,Drivers;
  const
    mx=1;my=1;
    w:array [1..8,1..2] of shortint
     =(( 1, 1),( 1, 0),( 1,-1),
       ( 0, 1),        ( 0,-1),
       (-1, 1),(-1, 0),(-1,-1));
  var
    maxx,maxy,nl:word;
    color:array [1..8] of byte;
    k:array [0..30+1,0..24+1] of shortint;
    bd:array [0..30+1,0..24+1] of char;
    Px,Py:integer;
    i,j:integer;
    ch:char;
    ll:integer;
    printtime,first,over,p0:boolean;
    ty,tp,tn:real;
  function Exist(Path:string):boolean;
    var
      S: PathStr;
  begin
    S := FSearch(Path, GetEnv(''));
    Exist :=  S <> '';
  end;
  procedure ini;
    var
      f:text;
      i:integer;
  begin
    assign(f,'text.in');
    if not exist('text.in') then begin
      rewrite(f);
      writeln(f,'10 10 10');
      writeln(f,'11 2 4 1 6 3 7 8');
      close(f);
    end;
    reset(f);
    readln(f,maxx,maxy,nl);
    for i:=1 to 8 do read(f,color[i]);
    close(f);
  end;
  procedure gtime;
    var h,m,s,ss:word;
  begin
    gettime(h,m,s,ss);
    ty:=h*3600+m*60+s+ss/100;
    tp:=0;
  end;
  procedure prntime;
    var h,m,s,ss:word;
        n:integer;
  begin
    if not printtime then exit;
    gettime(h,m,s,ss);
    tn:=h*3600+m*60+s+ss/100;
    if tn-ty+tp<0 then tp:=tp+24*60*60;
    gotoxy(10,1);
    textcolor(red);
    if tn-ty+tp<1000 then n:=round(tn-ty+tp) else n:=999;
    if p0 then n:=0;
    write(n div 100,n div 10 mod 10,n mod 10);
  end;
    procedure print(x,y:integer);
    var col:boolean;
  begin
    gotoxy(x+1,y+1);
    col:=false;
    if bd[x,y] in ['1'..'8'] then textcolor(color[ord(bd[x,y])-48])
      else if (bd[x,y]='â')or(bd[x,y]='X')or(bd[x,y]='') then textcolor(12)
      else if bd[x,y]='?' then textcolor(8)
      else textcolor(15);
    textbackground(ord(col)*13);
    write(bd[x,y]);
    gotoxy(1,1);
    normvideo;
  end;
  procedure prnll;
  begin
    gotoxy(1,1);
    write(' ':4);
    gotoxy(1,1);
    textcolor(red);
    write(ll:4);
  end;
  procedure scrini;
  begin
    TextMode(Lo(LastMode)+Font8x8);      { use 43 or 50 lines on EGA/VGA }
    TextBackground(Black);
    TextColor(White);
    Clrscr;
  end;
  procedure pm;
  begin
    textcolor(green);
    gotoxy(2,maxy+my+2);
    write('Exit ³ Reset ³ Set');
  end;
  procedure init;
    var i,j:integer;
  begin
    clrscr;pm;
    over:=false;
    ll:=nl;
    prnll;
    px:=1;py:=1;
    for i:=1 to maxx do
     for j:=1 to maxy do
     bd[i,j]:='±';
    for i:=1 to maxx do
     for j:=1 to maxy do
     k[i,j]:=0;
    normvideo;
    for i:=1 to maxx do for j:=1 to maxy do print(i,j);
    gtime;
  end;
  procedure ran;
   var i,j,n,m:integer;
  begin
    n:=maxx*maxy;
    for i:=1 to maxx do
     for j:=1 to maxy do
      if k[i,j]=-1 then n:=n-1;
    n:=random(n)+1;
    for i:=1 to maxx do
     for j:=1 to maxy do begin
       if k[i,j]=-1 then n:=n+1;
       n:=n-1;
       if n=0 then begin
         k[i,j]:=-1;
         for m:=1 to 8 do
          if k[i+w[m,1],j+w[m,2]]<>-1
           then k[i+w[m,1],j+w[m,2]]:=k[i+w[m,1],j+w[m,2]]+1;
         exit;
       end;
     end;
  end;
  procedure clk;
  begin
    gotoxy(1,maxy+my+5);
    for i:=1 to maxy do begin
     for j:=1 to maxx do write(' ');
     writeln;
    end;
    gotoxy(1,1);
  end;
  function inputdata:char;
    var
      xi,yi,pa1,pa2:integer;
      event:tevent;
  begin
    initevents;
    pa1:=1;pa2:=1;ch:=#0;
    if keypressed then readkey;
    repeat
      prntime;
      getmouseevent(event);
      if event.what=1 then begin
        px:=event.where.x+1-mx;py:=event.where.y+1-my;
        if event.buttons=2 then ch:='x';
        if event.buttons=1 then ch:='z';
        if bd[px,py]in ['1'..'8'] then ch:='c';
      end;
      if (event.what=1) then
        if (event.where.y+1=maxy+my+2) then
          if event.where.x in [0..5] then ch:='q'
           else if event.where.x in [7..13] then ch:='r'
           else if event.where.x in [15..19] then ch:='s';
      if keypressed then if readkey=#27 then halt;
    until ((ch in ['z','x','c']) and(px in [1..maxx]) and (py in [1..maxy]))
          or (ch in ['q','r','s']);
    inputdata:=ch;
    doneevents;
  end;
  procedure qw(x,y:integer);
  begin
    if bd[x,y]='â' then ll:=ll+1;
    if bd[x,y]='±' then bd[x,y]:='â' else
     if bd[x,y]='â' then bd[x,y]:='?' else
     if bd[x,y]='?' then bd[x,y]:='±';
    if bd[x,y]='â' then ll:=ll-1;
    print(x,y);
    prnll;
  end;
  procedure fc(x,y:integer);
    var
      i:integer;
     procedure t(x,y:byte);
      var
        i,j,n:integer;
        flag:boolean;
      begin
        bd[x,y]:='°';
        repeat
          flag:=true;
          for i:=1 to maxx do
           for j:=1 to maxy do
             if bd[i,j]='°' then
              for n:=1 to 8 do
               if (bd[i+w[n,1],j+w[n,2]] in ['±','?'])
                 and (i>0)and(i<maxx+1)and(j>0)and(j<maxy+1)then begin
                 bd[i+w[n,1],j+w[n,2]]:=chr(k[i+w[n,1],j+w[n,2]]+48);
                 if bd[i+w[n,1],j+w[n,2]]='0'
                   then bd[i+w[n,1],j+w[n,2]]:='°';
                 flag:=false;
                 print(i+w[n,1],j+w[n,2]);
             end;
        until flag;
      end;
    begin
      if bd[x,y] in ['±','?'] then begin
      if k[x,y]>0 then bd[x,y]:=chr(k[x,y]+48);
      if k[x,y]<0 then begin
        for i:=1 to maxx do
         for j:=1 to maxy do begin
           if (bd[i,j]='â') and (k[i,j]<>-1) then begin
             bd[i,j]:='X';
             print(i,j);
           end;
           if (bd[i,j]<>'â') and (k[i,j]=-1) then begin
             bd[i,j]:='';
             print(i,j)
           end;
         end;
        over:=true;
      end;
    if k[x,y]=0 then t(x,y);
    print(x,y);
    end;
  end;
  procedure cl(x,y:integer);
    var i,m,n:integer;
  begin
    ran;
    k[x,y]:=0;
    for i:=1 to 8 do
     if k[x+w[i,1],y+w[i,2]]<>-1
      then k[x+w[i,1],y+w[i,2]]:=k[x+w[i,1],y+w[i,2]]-1
      else k[x,y]:=k[x,y]+1;
  end;
  procedure af(x,y:byte);
   var n:shortint;
  begin
    n:=k[x,y];
    for i:=1 to 8 do
     if px+w[i,1]<=maxx then if py+w[i,2]<=maxy then
     if px+w[i,1]>=1    then if py+w[i,2]>=1    then
     if bd[px+w[i,1],py+w[i,2]]='â'
     then n:=n-1;
    if (n<=0) and (not (bd[x,y] in ['±','?'])) then
    for i:=1 to 8 do if
     (bd[px+w[i,1],py+w[i,2]] in ['±','?'])
     then fc(px+w[i,1],py+w[i,2]);
  end;
  function ar:boolean;
    var n,i,j:integer;
  begin
    n:=0;
    for i:=1 to maxx do
     for j:=1 to maxy do
       if bd[i,j] in ['1'..'8','°'] then n:=n+1;
    ar:=n=maxx*maxy-nl;
  end;
  procedure initj;
  begin
     fillchar(bd,sizeof(bd),'â');
     p0:=true;
     init;
     for i:=1 to nl do ran;
     first:=true;printtime:=true;
  end;
  procedure arr;
  begin
       i:=px;j:=py;px:=0;
       print(i,j);
       for i:=1 to maxx do
        for j:=1 to maxy do
         if bd[i,j]='±' then begin
           bd[i,j]:='â';
           print(i,j);
           ll:=0;
           prnll;
         end;
     gotoxy(2,maxy+my+1);
     textcolor(red+16);
     write('Congratulations!');
     printtime:=false;
  end;
  procedure overr;
  begin
     gotoxy(2,maxy+my+1);
     textcolor(red+16);
     write('Game over!');
     printtime:=false;
  end;
  procedure run;
  begin
    if ar then arr;
    repeat
      ch:=inputdata;
      if not over then begin
        if ch='x' then qw(px,py);
        if ch='z' then if not first then fc(px,py) else begin
          gtime;p0:=false;
          if k[px,py]=-1 then cl(px,py);
          fc(px,py);
          first:=false;
        end;
        if ch='c' then af(px,py);
      end;
      if (ch='r') or (ch='s') then exit;
      if ar then arr;
      if over then overr;
      print(px,py)
    until ch='q';
  end;
  procedure sethard;
    procedure inputnum(var n:word;const max:word);
      var
        c:char;
        x,y:byte;
    begin
      x:=wherex;y:=wherey;write(n);
      repeat
        repeat
          c:=readkey;if c=#0 then c:=readkey;
          if c=#27 then begin n:=max+1; exit end;
          if c in ['0'..'9'] then n:=n*10+ord(c)-48;
          if c=#8 then n:=n div 10;
          if n>max then n:=n div 10;
          gotoxy(x,y);write(n,' '#8);
        until c=#13;
        if n<10 then write('');
      until n>=10;
    end;
    function choose:byte;
      var event:tevent;i:byte;
      const
        printstr:array [0..4] of string[15]=
        ('Basic','Intermediate','Advanced','User Define...','Exit');
    begin
      clrscr;
      initevents;
      gotoxy(1,1);
      textcolor(green);
      for i:=0 to 4 do writeln(printstr[i]);
      repeat
        getmouseevent(event);
        if keypressed and (readkey=#27) then begin
          doneevents;choose:=5;exit;
        end;
        if event.what=4 then begin
          gotoxy(1,1);
          textcolor(green);
          for i:=0 to 4 do writeln(printstr[i]);
        end;
      until (event.what=1) and (event.where.y<5) and (event.where.x<11);
      choose:=event.where.y;
      doneevents;
    end;
    function input(y:byte):byte;
      var maxx1,maxy1,nl1:word;
    begin
      input:=1;
      case y of
        0:begin maxx:=10;maxy:=10;nl:=10; end;
        1:begin maxx:=16;maxy:=16;nl:=40; end;
        2:begin maxx:=30;maxy:=16;nl:=99; end;
        3:begin
          clrscr;maxy1:=maxy;maxx1:=maxx;nl1:=nl;
          write('(10<=) Height (<=24) :');inputnum(maxy1,24);if maxy1>24 then exit;writeln;
          write('(10<=) Width  (<=30) :');inputnum(maxx1,30);if maxx1>30 then exit;writeln;
          write('(10<=) num. of mine (<=',(maxx1-1)*(maxy1-1),'):');
             inputnum(nl1,(maxx1-1)*(maxy1-1));if nl1>(maxx1-1)*(maxy1-1) then exit;writeln;
          maxy:=maxy1;maxx:=maxx1;nl:=nl1;
        end;
      end;
      input:=0;
    end;
    var f:text;
  begin
    repeat until input(choose)=0;
    assign(f,'text.in');
    rewrite(f);
    writeln(f,maxx,' ',maxy,' ',nl);
    for i:=1 to 8 do write(f,color[i],' ');
    close(f);
  end;
begin
  randomize;
  scrini;ini;
  repeat
     initj;
     run;
     if ch='s' then sethard;
  until ch='q';
end.
