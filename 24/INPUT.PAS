unit input;
interface
  uses crt,dos;
  var userstr:string;
  function inputdata:string;
implementation
  const
    tsy='Input a expression:';
    max{s}=120;
  var s:string;
      fout:text;
  function inputdata:string;
    var
      ty,tp,tn:real;
      s:string;
      c:char;
      over:boolean;
      i:integer;
    procedure gtime;
      var
        h,m,s,ss:word;
    begin
      gettime(h,m,s,ss);
      ty:=h*3600+m*60+s+ss/100;
      tp:=0;
    end;
    procedure prntime;
      var
        h,m,s,ss:word;
        n:integer;
        x,y:integer;
    begin
      gettime(h,m,s,ss);
      tn:=h*3600+m*60+s+ss/100;
      if tn-ty+tp<0 then tp:=tp+24*60*60;
      textcolor(red);
      if tn-ty+tp<=max then n:=round(tn-ty+tp) else n:=max;
      n:=max-n;
      x:=WhereX;y:=WhereY;
      gotoxy(20,2);
      write(n div 100,n div 10 mod 10,n mod 10);
      gotoxy(x,y);
      if n=0 then begin over:=true;write('') end;
    end;
  begin
    gotoxy(1,3);textcolor(12);write(tsy);
    s:=''; gtime; over:=false;
    repeat
      while (not keypressed) and (not over) do prntime;
      if keypressed then c:=readkey;
      if (length(s)=20)and(c<>#8)and(c<>#13) then write('');
      if not ((length(s)=0)and(c=#8))
         and not ((length(s)>=20)and(c<>#8))
         and not (c=#27) then begin
        textcolor(14);
        if c='/' then c:='ö';
        if c in ['[','{','<'] then c:='(';
        if c in [']','}','>'] then c:=')';
        if c=#8 then s:=copy(s,1,length(s)-1);
        if c in ['0'..'9','(',')','+','-','*','ö'] then s:=s+c;
        if c in ['0'..'9','(',')',#8,'+','-','*','ö'] then write(c);

        if c=#8 then write(' ',#8);
      end;
      if c in [#13,#27] then over:=true;
    until over;
    for i:=1 to length(s) do
      if s[i]='ö' then s[i]:='/';
    if c=#27 then s:='' else if s='' then s:=' ';
    inputdata:=s;
  end;
end.
