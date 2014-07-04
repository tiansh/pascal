unit check;
interface
  uses ran,input,jsbds;
  function ric:boolean;
implementation
function ric:boolean;
  var
    a:boolean;
  function check(s:string):boolean;
    var
      i,n:integer;
      b:array [1..13]of shortint;
      flag:boolean;
  begin
    flag:=true;
    for i:=1 to 13 do b[i]:=0;
    for i:=1 to 4 do inc(b[kb[i]]);
    for i:=1 to length(s) do
      if s[i] in ['0'..'9'] then begin
        n:=ord(s[i])-48;
        while s[i+1] in ['0'..'9'] do begin
          i:=i+1;
          n:=n*10+ord(s[i])-48;
          if n>13 then begin check:=false;exit; end;
        end;
        if n<=13 then dec(b[n]) else flag:=false;
      end;
    for i:=1 to 13 do if b[i]<>0 then flag:=false;
    check:=flag
  end;
  function hf(s:string):boolean;
    var
      i:byte;k:shortint;
    const
      n=7;
      a:array [1..n] of string[2]=
      ('++','0(',')0','(+','+)','()',')(');
  begin
    for i:=1 to length(s) do case s[i] of
      '+','-','*','/':s[i]:='+';
      '0'..'9':s[i]:='0';
    end;
    hf:=true;
    for i:=1 to n do if pos(a[i],s)<>0 then hf:=false;
    k:=0;for i:=1 to length(s) do begin
      if s[i]='(' then k:=k+1 else if s[i]=')' then k:=k-1;
      if k<0 then hf:=false;
    end;
    if k<>0 then hf:=false;
  end;
begin
  rm;
  userstr:=inputdata;if userstr='' then exit;
  if check(userstr) and hf(userstr) then ric:=jsbdsb(userstr) else ric:=false;
end;
end.