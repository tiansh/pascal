uses print,dos,constant,graph,CRT,bmp;
  label 1,2,3;
  const
    str:array [1..maxcolor] of string
      =('1:Blue','2:Red','3:Green','4:Yellow',
        '5:White','6:DGray','7:Brown','8:Magenta');
    cn:array [1..maxcolor] of byte
      =(1,4,2,14,7,8,6,5);
  procedure printtext(s:string;x,y:word;size,color:byte);
  begin
    setcolor(color);
    if size>1 then SetTextStyle(TriplexFont, HorizDir, Size)
    else SetTextStyle(DefaultFont, HorizDir, Size);
    OutTextXY(X , Y , s);
  end;
  function Exist(Path:string):boolean;
    var
      S: PathStr;
  begin
    S := FSearch(Path, GetEnv(''));
    Exist := S <> '';
  end;
  var
    a:constant.bd;
    i,x,y,x1,y1,x0,x10:shortint;
    quit,move,changed:boolean;
    c,h:char;path:string;
    code:integer;
  function finish:boolean;
    var
      i,j:byte;
      flag:boolean;
  begin
    flag:=true;
    for i:=1 to mx do
     for j:=1 to my do
     if a[i,j]>0
     then flag:=false;
    finish:=flag;
  end;
  procedure fall;
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
       a[i,j]:=0;
     end;
  end;
  procedure load(filename:string);
    var
      fileinp:text;
      i,j:byte;
      c:char;
  begin
    assign(fileinp,filename);
    reset(fileinp);
    fillchar(a,sizeof(a),0);
    for i:=1 to my+1 do begin
      for j:=1 to mx do begin
        read(fileinp,c);
        case c of
          #48..#57:a[j,i]:=ord(c)-48;
          'F','f':a[j,i]:=-1;
          'E','e':a[j,i]:=-2;
          'W','w':begin
                    read(fileinp,c);
                    a[j,i]:=-3;
                    if c in ['r','R'] then w[j,i]:=maxcolor+1 else w[j,i]:=ord(c)-48;
                  end;
          'R','r':a[j,i]:=9;
        end;
      end;
      readln(fileinp);
    end;
  end;
  procedure save;
    var
      i,j:byte;
  begin
    closegraph;
    fall;
    if finish or not changed then exit;
    write('Save? [Y]es/[N]o:');
    repeat c:=readkey; until c in ['Y','y','N','n',#27];
    writeln(c);
    if c in ['n','N',#27] then exit;
    i:=1;while exist(dir+inttostr(i)+extension) do inc(i);
    if h='2' then val(path,i,code);
    if not exist(paramstr(1)) then begin
      write('Saving "'+inttostr(i)+'" ...');
      assign(output,dir+IntToStr(I)+extension)
    end else begin
      write('Saving "',paramstr(1)+'" ...');
      assign(output,paramstr(1));
    end;
    rewrite(output);
    for i:=1 to my do begin
      for j:=1 to mx do begin
        if a[j,i]=9 then write('R') else
          if a[j,i]>=0 then write(a[j,i]) else
          if a[j,i]=-1 then write('F') else
          if a[j,i]=-2 then write('E') else
          if a[j,i]=-3 then begin
            write('W');
            if w[j,i]=maxcolor+1 then write('R') else write(w[j,i]);
          end
      end;
      writeln;
    end;
  end;
begin
  clrscr;
  changed:=false;
  if paramcount>0 then
   if exist(paramstr(1)) then goto 3;
   if exist(dir+paramstr(1)+extension) then begin
    path:=paramstr(1);goto 2;
  end;
  fillchar(a,sizeof(a),0);
1:writeln('1:Creat a new map. 2:Edit a old map.');
  write('Chose:');
  repeat h:=readkey; if h=#27 then halt; until (h='1') or (h='2');
  writeln(h);
  if h='2' then begin
    repeat
      write('Map Index:');
      readln(path);
2:    val(path,i,code);
      if not exist(dir+path+extension) or (code<>0) or (i<=0) then begin
        writeln('File not found or invalid index!');
        goto 1;
      end;
    until exist(dir+path+extension);
3:  load(dir+path+extension);
    inigraph;
    printa(a);
  end else inigraph;
  bmp16('-127.bmp',px,py,0);
  pu;x:=1;y:=1;x0:=1;
  printtext(#24#25#26#27':Move '#17#217':Change',px+60,py-20,1,15);
  printtext('"1"-"'+chr(maxcolor+48)+'":SetColor "0","DEL":Delete "F","W","E":Function Balls Esc:Cancel',px-90,py-10,1,15);
  for i:=1 to 8 do
    printtext(str[i],px+(i-1) mod 2*mx*r+5,
              py+round(sqrt(3)*(my-1)*r)+2*r+(i-1) div 2*20+5,
              2,cn[i]);
  quit:=false;
  repeat
    bmp16('-127.bmp',px+2*(x-1)*r+((y+1) mod 2)*r,py+round(sqrt(3)*(y-1)*r),0);
    while keypressed do readkey;
    x1:=x;y1:=y;
    c:=readkey;pq(a,x,y);
    case c of
      #0:begin
        case readkey of
          (*#72{Up}, #75{Left}, #77{Right}, #80{Down}, #27{Esc}*)
          #72:if y=1 then write('') else y:=y-1;
          #75:if x=1 then write('') else x:=x-1;
          #77:if x=mx-(y+1)mod 2 then write('') else x:=x+1;
          #80:if y=my then write('') else y:=y+1;
          #83{Delete}:c:='0';
          #6{Crtl-Delete}:begin
            fillchar(a,sizeof(a),0);printa(a);changed:=true;
          end;
          #107,#45:quit:=true;
        end;
        if not odd(y) and (x=mx) then x:=x-1;
      end;
      #27:quit:=true;
      'F','f','E','e','W','w','R','r',#48..chr(48+maxcolor):begin
         case c of
           'F','f':c:=#47;
           'E','e':c:=#46;
           'R','r':c:='9';
           'W','w':begin
             printtext('"1"-"'+chr(maxcolor+48)+'":SetColor "0","DEL":Delete "F","W","E":Function Balls Esc:Cancel',
                       px-90,py-10,1,8);
             printtext('"1"-"'+chr(maxcolor+48)+'":SetColor ',px-90,py-10,1,15);
             repeat
               c:=readkey;
               if not (c in ['1'..chr(48+maxcolor+1),'r','R']) then write('');
             until c in ['1'..chr(48+maxcolor+1),'r','R'];
             if c in ['r','R',chr(48+maxcolor+1)] then w[x0,y]:=maxcolor+1 else w[x0,y]:=ord(c)-48;
             c:=#45;
             printtext(#24#25#26#27':Move '#17#217':Change',px+60,py-20,1,15);
             printtext('"1"-"'+chr(maxcolor+48)+'":SetColor "0","DEL":Delete "F","W","E":Function Balls Esc:Cancel'
                      ,px-90,py-10,1,15);
           end;
         END;
      end;
    end;
    if c in [#45..'9'] then begin a[x,y]:=ord(c)-48;changed:=true; end;
    pq(a,x,y);
  until quit;
  save;
end.