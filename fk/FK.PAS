program FangKuai;
  uses Dos,Crt,Graph;
   const
     n{brick size}=20;
     file_path='text.in';
   var
     delay_time:array [1..10] of REAL;
     bd:array[0..11,-3..21] of byte;
     times:array [1..20] of word;
     max_d_t,i,j,k,n1,n2,m,nn1,nn2,sp:integer;
     score:longint;
     br:array[1..20,1..4,1..4,1..4] of boolean;
     colour:array [1..20] of byte;
     c:char;
     ju:real;

  procedure done; begin closegraph; halt(0); end;

  procedure graphini;
    var
      Gd, Gm: Integer;
  begin
    Gd := Detect;
    InitGraph(Gd, Gm, ' ');
    if GraphResult <> grOk then
      Halt(1);
  end;

  function Find(Path : string): boolean;
    var
      S : PathStr;
  begin
    S := FSearch(Path, GetEnv(''));
    Find := S <> ''
  end;

  procedure prn(x,y:byte);
    var
      i,j:integer;
  begin
    for i:=2 to n div 2 - 1 do
      Rectangle(40+2*i+n*x,2*i+n*y,40-2*i+n*(x+1),-2*i+n*(y+1));
    line(43+n*x,3+n*y,37+n*(x+1),-3+n*(y+1));
    line(37+n*(x+1),3+n*y,43+n*x,-3+n*(y+1));
  end;
procedure PrintBMP(path:string;x,y:longint;color:byte);
  const
    f=62;
  var
    fin:text;
    width,height,m:word;
    a:array [1..8] of boolean;
    n,k:byte;
    i,j,l:longint;

begin
  assign(fin,path);
  reset(fin);
  for i:=1 to 18 do read(fin,c);
  read(fin,c);m:=ord(c);read(fin,c);width:=ord(c)*256+m;
  for i:=1 to 2 do read(fin,c);
  read(fin,c);m:=ord(c);read(fin,c);height:=ord(c)*256+m;
  reset(fin);
  for i:=1 to f do read(fin,c);
  i:=1;j:=1;
  while (i<=height) do begin
    read(fin,c);
    n:=ord(c);
    for k:=1 to 8 do begin
      if n mod 2=1 then a[9-k]:=true else a[9-k]:=false;
      n:=n div 2;
    end;
    for k:=1 to 8 do begin
      putpixel(x+j,y+height+1-i,color*ord(not a[k]));
      j:=j+1;
      if j>width then begin
        k:=9;
        j:=1;
        i:=i+1;
        for l:=1 to 3-(((width+7)div 8+3)mod 4) do read(fin,c);
      end;
      if j=1 then break;
    end;
  end;
  close(fin);
end;
  procedure pg(st:string; X, Y, Size, Color: Integer);
  begin
    setcolor(color);
    SetTextStyle(DefaultFont, HorizDir, Size);
    OutTextXY(X, Y, st);
  end;

  function IntToStr(I: Longint): String;
  { Convert any integer type to a string }
  var
   S: string[11];
  begin
   Str(I, S);
   IntToStr := S;
  end;

 procedure pr(n1,n2,x,y:integer;color:byte);
  var i,j:integer;
 begin
   for j:=1 to 4 do
    for i:=1 to 4 do
     if (br[n1,n2,i,j]) and (j+y>0) then begin
       setcolor(color);
       prn(i+x,j+y);
     end;
 end;
 procedure print;
  var i,j:integer;
 begin
   for i:=0 to 11 do
    for j:=1 to 21 do begin
     setcolor(bd[i,j]);
     prn(i,j);
    end;
   for i:=1 to 4 do
    for j:=1 to 4 do begin
     setcolor(ord(br[nn1,nn2,i,j])*colour[nn1]);
     prn(11+i,j);
    end;
    setcolor(black);
    for i:=1 to 15 do line(90,i,149,i);
    pg(inttostr(score),90,1,2,lightred);
 end;

 procedure init;
  var
    i,j,k,l:integer;
    f:text;
    d,n:integer;
    c:char;
 begin
   fillchar(bd,sizeof(bd),false);
   randomize;
   for i:=1 to 21 do begin
     bd[0,i]:=7;
     bd[11,i]:=7;
   end;
   for i:=1 to 10 do bd[i,21]:=7;
  if (ParamCount>0) and find(ParamStr(1)) then assign(f,ParamStr(1)) else begin
   if not find(File_path) then begin
     TextColor(blink+yellow);
     TextBackground(blue);
     WriteLn('File not found!');
     readln;
     Halt(2);
   end;
   assign(f,file_path);
  end;
   reset(f);
   readln(f,m);
   readln(f);
   for k:=1 to m do begin
   for l:=1 to 4 do
    for i:=1 to 4 do begin
     for j:=1 to 4 do begin
       read(f,d);
       br[k,l,j,i]:=d=1;
     end;
     readln(f);
    end;
   readln(f);
   end;
   n:=1;
   for i:=1 to m do read(f,colour[i]);
   readln(f,max_d_t);
   for i:=1 to max_d_t do read(f,delay_time[i]);
   graphini;
   printbmp('score.bmp',50 ,0,lightred);
   printbmp('speed.bmp',170,0,lightred);
   printbmp('next.bmp' ,280,0,blue);
   setcolor(lightgreen);
   line(40,20+2*fangkuai.n,40+12*fangkuai.n,20+2*fangkuai.n);
 end;
 function go:boolean;
 begin
   go:=false;
   for i:=1 to 10 do if bd[i,2]<>0 then go:=true;
 end;
 procedure build(var n1,n2,x,y:integer);
 begin
   n1:=nn1;
   n2:=nn2;
   nn1:=random(m)+1;
   nn2:=random(4)+1;
   x:=4;y:=-1;
 end;
 function ch(n1,n2,x,y:integer):byte;
  var
    i,j:integer;
    flag:byte;
 begin
   flag:=0;
   for j:=1 to 4 do
    for i:=1 to 4 do
     if not ((i+x>=11) or (j+y>=21) or (i+x<=0) or (j+y<=0)) then begin
      if (br[n1,n2,i,j]) and (bd[i+x,y+j]<>0) then flag:=flag or 1 end
     else if (br[n1,n2,i,j]) and ((i+x>=11) or (i+x<=0) or (y+j>=21)) then flag:=flag or 2;
   ch:=flag;
 end;
 procedure d(n1,n2,x,y:integer);
  var i,j:integer;
 begin
   for j:=1 to 4 do
    for i:=1 to 4 do
     if (br[n1,n2,i,j]) then begin
       bd[i+x,j+y]:=colour[n1];
     end;
 end;
 procedure q;
   var
     x,y,i,j,k,h:integer;
     b:boolean;
     t:array [1..4] of byte;
 begin
   for h:=4 downto 1 do t[h]:=0;h:=0;
   for y:=20 downto 1 do begin
     b:=true;
     for x:=1 to 10 do if bd[x,y]=0 then b:=false;
     if b then begin
       ju:=ju*0.99723;
       inc(h);t[h]:=y;
     end;
   end;
   print;
   for k:=h downto 1 do begin
    for i:=t[k] downto 1 do begin
     for j:=1 to 10 do bd[j,i]:=bd[j,i-1];
    end;
    print;sound(1044);delay(200);nosound;
   end;
   score:=score+h;
   print;
 end;
 procedure co;
   var c:char;
 begin
   pg('?',210,1,2,lightred);
   repeat c:=readkey; if c=#27 then done; until (c in ['0'..'9']) and (ord(c)-47<=max_d_t);
   ju:=delay_time[ord(c)-47];sp:=ord(c)-47;
   pg('?',210,1,2,0);
   pg(c,210,1,2,lightred);
 end;
 procedure play;
  label 1,2,3,4;
  var x,y,n1,n2,i,j,k:integer;
      t1,t2:integer;
      bre:boolean;
 begin
   build(n1,n2,x,y);print;
   co;
   repeat
     q;
     build(n1,n2,x,y);
     print;pr(n1,n2,x,y,colour[n1]);
     while keypressed do c:=readkey;
     repeat
      bre:=false;
        while (not keypressed) and (t2<ju) do begin
          t2:=t2+1;
          delay(1);
        end;
        if t2<ju then c:=readkey else c:='s';
        if c=#0 then c:=readkey;
      case c of
        's','S',#0,#80{Down}:begin
                  if not boolean(ch(n1,n2,x,y+1)) then begin
                    pr(n1,n2,x,y,black);
                    y:=y+1;
                    pr(n1,n2,x,y,colour[n1])
                   end else begin
                     bre:=true;
                     d(n1,n2,x,y);
                   end;
                   t1:=0;t2:=0;
                  end;
        'a','A',#75{Left}:begin
                  if not boolean(ch(n1,n2,x-1,y)) then begin
                   pr(n1,n2,x,y,black);
                    x:=x-1;
                    pr(n1,n2,x,y,colour[n1])
                   end;
                end;
        'd','D',#77{Right}:begin
                  if not boolean(ch(n1,n2,x+1,y)) then begin
                    pr(n1,n2,x,y,black);
                    x:=x+1;
                    pr(n1,n2,x,y,colour[n1])
                   end;
                end;
        'w','W',#72,'z','Z'{Up}:begin
                  pr(n1,n2,x,y,black);
                  n2:=n2+1;if n2=5 then n2:=1;
                  for i:=0 to 4 do
                   for j:=-1 to 1 do if j<>0 then begin
                     k:=ch(n1,n2,x+i*j,y);
                     if not boolean(k) then goto 1;
                     if boolean(k and 2) then continue;
                     n2:=n2-1;if n2=0 then n2:=4; write('');goto 2;
                   end;
                  1:x:=x+i*j;
                  2:pr(n1,n2,x,y,colour[n1]);
                end;
        #13,#32,'X','x'{Up2}:begin
                  pr(n1,n2,x,y,black);
                  n2:=n2-1;if n2=0 then n2:=4;
                  for i:=0 to 4 do
                   for j:=-1 to 1 do if j<>0 then begin
                     k:=ch(n1,n2,x+i*j,y);
                     if not boolean(k) then goto 3;
                     if boolean(k and 2) then continue;
                     n2:=n2+1;if n2=5 then n2:=1; write('');goto 4;
                   end;
                  3:x:=x+i*j;
                  4:pr(n1,n2,x,y,colour[n1]);
                end;
        'p','P':begin
                  c:=readkey;
                  c:=' ';
                end;
      end;
     until bre or (c=#27) or (c=#107);
   until go or (c=#27) or (c=#107);
   if (c<>#27) and (c<>#107) then begin
     PrintBMP('Gameover.bmp',300,200,red);
     repeat c:=readkey; until (c in [#27,'',#32,#13])
      or ((c=#0) and (readkey in [#107]));
   end;
 end;
begin
  repeat
    init;
    print;
    play;
    closegraph;
  until c<>'';
end.
