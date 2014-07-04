unit rand;
interface
  uses constvar;
  procedure rando(var a:bd);
implementation
  var
    d:array [1..3] of record x,y:byte end;
  procedure ran(var a:bd);
    var
      i,j,n:byte;
      p:tplant;
    const
      m:array [1..4,1..2] of shortint=
      ((0,1),(-1,0),(0,-1),(1,0));
  begin
    randomize;
   repeat
    n:=0;fillchar(a,sizeof(a),0);
    with d[1] do begin x:=0;y:=0 end;d[2]:=d[1];d[3]:=d[2];
    for i:=1 to 20 do begin
      with p do begin x:=random(8)+1;y:=random(8)+1;w:=random(3)+1 end;
      if p.check(a) then begin
        with d[n+1] do begin x:=p.x+m[p.w,1]; y:=p.y+m[p.w,2]; end;
        for i:=1 to 5 do for j:=1 to 5 do begin
          if pw[p.w].map[j,i] then a[(p.x+i-pw[p.w].head.x),(p.y+j-pw[p.w].head.y)]:=1;
          if (j=pw[p.w].head.y) and (i=pw[p.w].head.x) then a[(p.x+i-pw[p.w].head.x),(p.y+j-pw[p.w].head.y)]:=2;
        end;
        n:=n+1;if n=3 then exit;
      end;
    end;
   until n=3;
  end;
  function num(var l:bd;j,k:byte;t:byte):byte;
    var
      n:byte;
  begin
    if l[j,k]<>t then num:=0 else begin
      l[j,k]:=3;n:=1;
      if j<>1 then n:=n+num(l,j-1,k,t);
      if j<>9 then n:=n+num(l,j+1,k,t);
      if k<>1 then n:=n+num(l,j,k-1,t);
      if k<>9 then n:=n+num(l,j,k+1,t);
      num:=n;
    end;
  end;
  procedure rando;
    const
      tt=100;
    var
      l:array [1..tt] of bd;
      i,j,k:byte;
      m:byte;n:real;
      max:real;mt:byte;
  begin
    mt:=1;
    for i:=1 to tt do begin
      ran(l[i]);
      n:=0;
      for j:=1 to 2 do for k:=j+1 to 3 do n:=n+sqrt(sqr(d[j].x-d[k].x)+sqr(d[j].y-d[k].y));
      n:=100*n*n;
      for j:=1 to 9 do for k:=1 to 9 do begin
        m:=num(l[i],j,k,0);
        if m>5 then n:=n+m*m;
      end;
      if i=1 then max:=n;
      if n>max then begin mt:=i;max:=n; end;
    end;
    for i:=1 to 9 do for j:=1 to 9 do begin
      if l[mt,i,j]=3 then l[mt,i,j]:=0;
    end;
    a:=l[mt];
  end;
end.