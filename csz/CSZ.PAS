program gn;
 type int_1_4=array [1..4] of integer;
      st_5=string[5];
 var i,j,k:integer;
     numn,numg:int_1_4;
     ga,gb:array [1..8] of integer;
     nun:array [1..8,1..4] of integer;
     flag:boolean;
     ch:char;
 procedure init;
  var r_g:integer;
 begin
   randomize;
   for i:=1 to 4 do begin
     r_g:=random(10-i);
     numn[i]:=r_g;
   end;
   for k:=1 to 4 do
    for i:=1 to 4 do
    for j:=1 to i-1 do
    if numn[i]=numn[j] then begin
      numn[i]:=succ(numn[i]);
      numn[i]:=numn[i] mod 10
    end;
    flag:=false;
    writeln;writeln;
 end;
 function readnum(var num:int_1_4):boolean;
  var st5:st_5;
  function realnum(numl:st_5):boolean;
   var flagl:boolean;
  begin
    flagl:=true;
    if length(numl)<>4 then flagl:=false;
    realnum:=flagl;
    if not flagl then writeln('ERROR:length');
    if flagl then begin
      for i:=1 to 4 do
       if not (numl[i] in ['0'..'9']) then
        flagl:=false;
      if not flagl then begin
        realnum:=false;
        writeln('ERROR:char');
      end;
      if flagl then begin
        for i:=1 to 4 do
         for j:=1 to i-1 do
         if numl[i]=numl[j] then flagl:=false;
        if not flagl then begin
          writeln('ERROR:same');
          realnum:=false;
        end;
      end;
    end;
    if not flagl then write('')
 end;
 procedure lr(st:st_5);
   begin
     if k<>1 then writeln;
     for i:=1 to k-1 do begin
       for j:=1 to 4 do write(nun[i,j]);
       writeln(' ',ga[i],'A',gb[i],'B');
     end;
     write('Guess number:');
     readln(st5);
   end;
 begin
   lr(st5);
   while not realnum(st5) do lr(st5);
   for i:=1 to 4 do num[i]:=ord(st5[i])-48;
 end;
 procedure ab(n,g:int_1_4);
  var a,b:integer;
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
    if a=4 then begin
      writeln('You are right! Congratulations!');
      k:=8;
      flag:=true;
    end;
    if (a<>4) and (k<>8) then for i:=1 to k do write(' ');
    ga[k]:=a;gb[k]:=b;
    for i:=1 to 4 do nun[k,i]:=g[i];
 end;
begin
 init;
 for k:=1 to 8 do begin
   readnum(numg);
   ab(numn,numg);
 end;
 writeln;
 if not flag then begin
   writeln('Wrong!');
   write('right answer is:');
   for i:=1 to 4 do write(numn[i]);
   writeln;
 end;
 readln;
end.