program guesscsz;
  {$M 8192,0,0}
  uses Dos;
  const
    ti1='#';
    ti2=':';
    gu1='Is "';
    gu2='" correct?';
    wa1='Is "';
    wa2='" correct?';
    inp='a b: ';
    re1='Answer is "';
    re2='".';
    out='Press enter exit...';
  type
    string4=string[4];
  var
    list,able:array [0..9999] of boolean;
    A,B:byte; i:word; max:real; times:byte;
  procedure cmd(command:string);
  begin
    Command := '/C ' + Command;
    SwapVectors;
    Exec(GetEnv('COMSPEC'), Command);
    SwapVectors;
  end;
  function cut(n:word;w:byte):byte;
  begin
    while w<>4 do begin n:=n div 10; w:=w+1; end; cut:=n mod 10;
  end;
  procedure init;
    var
      i:word;
  begin
    for i:=0 to 9999 do
     if  (cut(i,1)=cut(i,2)) or (cut(i,1)=cut(i,3)) or (cut(i,1)=cut(i,4))
      or (cut(i,2)=cut(i,3)) or (cut(i,2)=cut(i,4)) or (cut(i,3)=cut(i,4))
       then able[i]:=false else able[i]:=true;
    list:=able;
    randomize;
    cmd('cls');
  end;
  function Ir(I: Longint): String;
  { Convert any integer type to a string }
  var
   S: string[11];
  begin
   Str(I, S);
   Ir := S;
  end;
  function IntToStr(I: word): String4;
  var
   S: string4;
  begin
   Str(I, S);
   while length(s)<>4 do s:='0'+s;
   IntToStr:=s;
  end;
  procedure ab(n,g:string4;var a,b:byte);
    var
      i,j:byte;
  begin
    a:=0;b:=0;
    for i:=1 to 4 do
     for j:=1 to 4 do
     if n[i]=g[j] then b:=b+1;
    for i:=1 to 4 do
     if n[i]=g[i] then begin
       a:=a+1;
       b:=b-1;
     end;
  end;
  procedure checkall(i:string4;a,b:byte);
    var
      j,k:word;
      at,bt:byte;
  begin
    for j:=0 to 9999 do if able[j] then begin
      ab(inttostr(j),i,at,bt);
      if (at<>a) or (bt<>b) then able[j]:=false;
    end;
  end;
  function choseone(var max:real):word;
    var
      i,j,sti:word; a,b,k,l:byte;
      score:real; si:string4; ma:word;
      ablist:array [0..24] of word;
  begin
    sti:=random(10000);max:=-100;
    for i:=sti to sti+9999 do if list[i mod 10000] then begin
      score:=-ord(able[i mod 10000])*0.5;si:=inttostr(i mod 10000);
      fillchar(ablist,sizeof(ablist),0);
      for j:=0 to 9999 do if able[j] then begin
        ab(si,inttostr(j),a,b);
        inc(ablist[a*5+b]);
      end;
      b:=0;
      for a:=0 to 24 do begin
        score:=score+sqr(ablist[a]);
        if ablist[a]<>0 then b:=b+1;
      end;
      score:=score/exp(ln(b)*3);
      if max=-100 then begin choseone:=i mod 10000; max:=score; end;
      if score<max then begin choseone:=i mod 10000; max:=score; end;
    end;
  end;
  function ablenum:word;
    var
      i,n:word;
  begin
    n:=0;for i:=0 to 9999 do if able[i] then n:=n+1;ablenum:=n;
  end;
  function gettn:word;
    var
      i:word;
  begin
    for i:=1 to 9999 do if able[i] then gettn:=i;
  end;
begin
  init;times:=1;
  while not able[i] do i:=random(10000);
  writeln('Is "'+inttostr(i)+'" correct? ');
  writeln('Input a and b: ');
  readln(a,b);writeln(inttostr(i)+' has '+ir(a)+'A, and '+ir(b)+'B.');
  checkall(inttostr(i),a,b);
  while a<>4 do begin
    times:=times+1;
    i:=ablenum;if i=0 then begin
      writeln('Cannot find any valid answer.');
      writeln(out);
      readln;
      halt;
    end else if i=1 then begin
      writeln('the only answer.');
      i:=gettn;
      writeln(ti1+ir(times)+ti2,re1,inttostr(i),re2);
      break;
    end else writeln(''+ir(i)+' answers left.');
    if i>100 then writeln('wait...');
    i:=choseone(max);
     if able[i] then  writeln(ti1+ir(times)+ti2,gu1,inttostr(i),gu2)
       else           writeln(ti1+ir(times)+ti2,wa1,inttostr(i),wa2);
      writeln(inp);
      readln(a,b);writeln(inttostr(i)+' has '+ir(a)+'A, and '+ir(b)+'B.');
      checkall(inttostr(i),a,b)
  end;
  writeln('The answer is "',inttostr(i),'".');
  writeln('Thanks.');
  writeln(out);
  readln;
end.
