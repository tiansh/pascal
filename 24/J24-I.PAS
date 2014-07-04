 const
   prn:array [1..13] of string[3]
      =('A  ','2  ','3  ','4  ','5  ','6  ','7  ',
        '8  ','9  ','10 ','J  ','Q  ','K  ');
 var
   i:integer;
   k:array [1..4] of real;
  function j24(answer:byte):string;
    var
      i,i1,i2,j1,j2,k1,k2,k3:byte;
      kn:array [1..4]of real;
      flag,goal:boolean;total:word;
    function t(a,b:real;c:byte):real;
    begin
      case c of
        1:t:=a+b;
        2:t:=a-b;
        3:t:=b-a;
        4:t:=a*b;
        5:if b<>0 then t:=a/b else flag:=false;
        6:if a<>0 then t:=b/a else flag:=false;
      end;
    end;
    procedure print;
      var
        sn:array[1..4]of string;
        sc:array[1..4]of byte;
        i,j:integer;
      function l(m,n:byte;c:byte):string;
        var
          temp,a,b:string;
          t:byte;
      begin
        a:=sn[m];b:=sn[n];
        if c in [3,6] then begin
          temp:=a;a:=b;b:=temp;
          t:=sc[m];sc[m]:=sc[n];sc[n]:=t;
        end;
        if sc[n]<=c then b:='('+b+')';
        if (sc[m]<4)and(c>3) then a:='('+a+')';
        if c in [3,6] then c:=c-1;
        case c of
          1:l:=a+'+'+b;
          2:l:=a+'-'+b;
          4:l:=a+'*'+b;
          5:l:=a+'/'+b;
        end;
      end;
    begin
      for i:=1 to 4 do
        if kn[i]<10 then begin
          sn[i]:=' '; sn[i,1]:=chr(48+round(kn[i]));
        end else begin
          sn[i]:='  ';
          sn[i,1]:=chr(48+round(kn[i]) div 10);
          sn[i,2]:=chr(48+round(kn[i]) mod 10);
        end;
      for i:=1 to 4 do sc[i]:=7;
      sn[i1]:=l(i1,j1,k1);sn[j1]:=sn[4];sc[j1]:=sc[4];sc[i1]:=k1;
      sn[i2]:=l(i2,j2,k2);sn[j2]:=sn[3];sc[j2]:=sc[3];sc[i2]:=k2;
      sn[ 1]:=l( 1, 2,k3);
      writeln(sn[1]);
      goal:=true;
    end;
  begin
    total:=0;goal:=false;
    for i:=1 to 4 do kn[i]:=k[i];
    for i1:=1 to 3 do
     for j1:=i1+1 to 4 do
      for i2:=1 to 2 do
       for j2:=i2+1 to 3 do
        for k1:=1 to 6 do
         for k2:=1 to 6 do
          for k3:=1 to 6 do begin
            for i:=1 to 4 do k[i]:=kn[i];
            flag:=true;
            k[i1]:=t(k[i1],k[j1],k1);
            k[j1]:=k[4];
            k[i2]:=t(k[i2],k[j2],k2);
            k[j2]:=k[3];
            if flag and (abs(t(k[1],k[2],k3)-answer)<1E-6) then
              print;
            if goal then exit;
          end;
    write('No Answer!');
  end;
begin
  for i:=1 to 4 do read(k[i]);
  readln;
  j24(24);readln;
end.
