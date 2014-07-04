program tuixz;
  uses
    dos,crt;
  type
    prin4=array [1..2,1..2] of char;
    char5=array [0..6] of prin4;
    byte5=array [0..6] of byte;
  const
    prn:char5=(((' ',' '),(' ',' ')),(('Û','Û'),('Û','Û')),
               (('\','/'),('/','\')),(('Ú','¿'),('À','Ù')),
               (('Ú','¿'),('À','Ù')),(('/','\'),('\','/')),
               ((' ',' '),(' ',' ')));
    color:byte5=(8,15,4,4,6,14,7);
    path_in='text.in';
    total=13;max=15;
  type
    tmi=array [1..max,1..max] of byte;

  var
    m,mr:tmi;
    ml:array [1..50] of tmi;
    lx,ly:array [1..50] of integer;
    ju,px,py,rx,ry,st:integer;
    pf,s:string;
    step:longint;
  procedure cmd(command:string);
  begin
    if Command <> 'exit' then begin
      SwapVectors;
      Exec(GetEnv('COMSPEC'), '/C ' + Command);
      SwapVectors;
      if DosError <> 0 then
         WriteLn('Could not execute COMMAND.COM');
    end
  end;
  procedure scrini;
  begin
    CheckBreak:=False;                   { turn off Contrl-C checking }
    TextMode(Lo(LastMode)+Font8x8);      { use 43 or 50 lines on EGA/VGA }
    TextBackground(Black);
    TextColor(White);
    Clrscr;                              { put message line on screen }
  end;
  procedure print(x,y:byte);
    var
      n:byte;
  begin
    if (x=px) and (y=py) then n:=5 else n:=m[x,y];
    textcolor(color[n]);
    gotoxy(x*2,2+y*2);
    write(prn[n,1,1],prn[n,1,2]);
    gotoxy(x*2,2+y*2+1);
    write(prn[n,2,1],prn[n,2,2]);
  end;
  procedure PrintStep;
    var
      x,y:integer;
  begin
    textcolor(red);
    x:=wherex;
    y:=wherey;
    gotoxy(5,1);
    if step>=1000000 then writeln('999999') else writeln('Step:',step:6);
    gotoxy(x,y);
  end;
  procedure printall;
    var i,j:integer;
  begin
    textcolor(0);textbackground(0);clrscr;
    for i:=1 to max do
     for j:=1 to max do
      print(j,i);
    PrintStep;
    gotoxy(1,1);
  end;
  procedure replay;
  begin
    m:=mr;
    px:=rx;py:=ry;
    step:=0;st:=0;
    printall;
  end;
  procedure ins(m:tmi;x,y:integer);
    var
      i:integer;
  begin
    if st=50 then begin
      for i:=2 to 50 do begin
        ml[i-1]:=ml[i];
        lx[i-1]:=lx[i];
        ly[i-1]:=ly[i];
      end;
    end;
    if st<>50 then inc(st);
    ml[st]:=m;
    lx[st]:=x;
    ly[st]:=y;
  end;
  procedure out(var m:tmi;var x,y:integer);
  begin
    if st>1 then begin
      dec(st);
      m:=ml[st];
      x:=lx[st];
      y:=ly[st];
      step:=step-1;
      printall;
    end else write('');
  end;
  procedure load(s:string);
    var
      i,j,n:integer;
      c:char;f:text;
  begin
    assign(f,'MAP\'+s+'.txt');
    reset(f);
    for i:=1 to max do begin
     for j:=1 to max do begin
       read(f,n);
       m[j,i]:=n;
       if n=5 then begin
         px:=j;py:=i;m[j,i]:=0;
       end;
     end;
     readln(f);
    end;
    close(f);
    mr:=m;rx:=px;ry:=py;
    ins(m,px,py);
  end;
  procedure init;
    var
      f:text;i,j:integer;
      p: pathstr;
      flag:boolean;
    procedure load_files;
    begin
      s:='1';
      step:=0;st:=0;
      load(s);
    end;
  begin
    scrini;
    flag:=true;
    load_files;
    printall;
  end;
  procedure play;
    const
      w:array [1..4,'x'..'y'] of shortint
       =((0,-1),(0,1),(-1,0),(1,0));
    var
      ch:char;
      t:byte;
      flag:boolean;
    procedure next;
      var i:integer;
    begin
      s[length(s)]:=succ(s[length(s)]);
      for i:=length(s) downto 2 do
        if s[i]=#58 then begin
          s[i-1]:=chr(ord(s[i-1])+1);
          s[i]:='0';
        end;
      if s[1]=#58 then s:='10'+copy(s,2,length(s)-1);
      ju:=ju+1;
      step:=0;st:=0;
    end;
    function tg:boolean;
      var
        i,j:integer;
    begin
      tg:=true;
      for i:=1 to max do
       for j:=1 to max do
        if m[i,j]=2 then tg:=false;
    end;
  begin
    while not tg do begin
      repeat
        ch:=readkey;
        if ch in ['r','R',''] then begin
          gotoxy(1,3);
          textcolor(7);write('Reset: ');
          textcolor(15);write('Y');
          textcolor(7);write('es ');
          textcolor(15);write('N');
          textcolor(7);write('o');
          repeat
            ch:=readkey;if ch=#0 then ch:=readkey;
          until ch in [#72,#75,#77,#80,#27,#26,'Y','y','N','n',#8];
          if ch in ['Y','y'] then replay else printall;
        end;
        if ch in ['z','Z',#26,''] then out(m,px,py);
      until ch in [#72{Up},#75{Left},#77{Right},#80{Down},#27{Esc}];
      if ch=#27 then halt;
      case ch of
        #72:t:=1;
        #80:t:=2;
        #75:t:=3;
        #77:t:=4;
      end;
      flag:=not(
            (m[px+w[t,'x'],py+w[t,'y']]=1)
            or ((m[px+w[t,'x'],py+w[t,'y']]in [3,4])
            and(m[px+w[t,'x']*2,py+w[t,'y']*2] in [1,3,4]))
            );
      if flag then begin
        if step<1000000 then step:=step+1 else step:=999999;
        PrintStep;
        if m[px+w[t,'x'],py+w[t,'y']]in [3,4] then begin
          if m[px+2*w[t,'x'],py+2*w[t,'y']]=0 then
            m[px+2*w[t,'x'],py+2*w[t,'y']]:=4
           else begin
             m[px+2*w[t,'x'],py+2*w[t,'y']]:=3;
           end;
          if m[px+w[t,'x'],py+w[t,'y']]=3
           then begin
             m[px+w[t,'x'],py+w[t,'y']]:=2;
           end else
             m[px+w[t,'x'],py+w[t,'y']]:=0;
          print(px+2*w[t,'x'],py+2*w[t,'y']);
        end;
        px:=px+w[t,'x'];
        py:=py+w[t,'y'];
        print(px-w[t,'x'],py-w[t,'y']);
        print(px,py);
        ins(m,px,py);
      end;
    end;
    gotoxy(1,2);
    textcolor(20);
    write('Congratulates!');
    gotoxy(1,1);
    ch:=readkey;
    next;
  end;
begin
 init;
 repeat
   textcolor(white);textbackground(black);
   play;
   if ju<=total then begin
     load(s);
     printall;
   end;
 until ju>total;
end.
