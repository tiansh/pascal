unit funcball;
interface
  uses constant,print,score,crt;
  procedure funcb(var a:bd;x,y:byte);
implementation
  procedure fire(var a:bd; x,y:byte);
    var i:shortint;
  begin
    a[x,y]:=0;
    pq(a,x,y);
    for i:=-1 to 1 do begin
      if a[x+i,y]<>0 then ls(10);
      a[x+i,y]:=0;
      pq(a,x+i,y);
    end;
    if y>1 then for i:=-1 to 2 do begin
      if a[x+i-y mod 2,y-1]<>0 then ls(10);
      a[x+i-y mod 2,y-1]:=0;
      pq(a,x+i-y mod 2,y-1);
    end;
    if y>2 then for i:=-1 to 1 do begin
      if a[x+i,y-2]<>0 then ls(10);
      a[x+i,y-2]:=0;
      pq(a,x+i,y-2);
    end;
  end;
  procedure electric(var a:bd; x,y:byte; f:boolean);
    var i:shortint;
  begin
    a[x,y]:=0;
    pq(a,x,y);
    if f then for i:=x downto 1 do begin
      ls(10*ord(a[i,y]<>0));
      a[i,y]:=-2; pq(a,i,y); delay(100);
      a[i,y]:=0;pq(a,i,y);
    end
     else for i:=x to mx do begin
      ls(10*ord(a[i,y]<>0));
      a[i,y]:=-2; pq(a,i,y); delay(100);
      a[i,y]:=0; pq(a,i,y);
    end;
  end;
  procedure water(var a:bd; x,y,w:byte);
    var i,j:shortint;
  begin
    a[x,y]:=0;
    pq(a,x,y);
    for j:=y to my do begin
      if (j-y) mod 2=0 then begin
        if a[x,j]>0 then begin a[x,j]:=w; pq(a,x,j); end;
      end else begin
        for i:=0 to 1 do if a[x-x mod 2+i,j]>0 then begin
          a[x-x mod 2+i,j]:=w;
          pq(a,x-x mod 2+i,j);
        end;
      end
    end
  end;
  procedure funcb;
    var xs,ys,i:byte;
    procedure f(var x,y:byte; i:byte);
    begin
      case i of
        1:begin x:=x+1; y:=y end;
        2:begin x:=x-1; y:=y end;
        3:begin x:=x; y:=y+1 end;
        4:begin x:=x; y:=y-1 end;
        5:begin x:=x-((y mod 2)*2-1); y:=y-1 end;
        6:begin x:=x-((y mod 2)*2-1); y:=y+1 end;
        else
      end;
    end;
  begin
    for i:=1 to 6 do begin
      xs:=x;ys:=y;
      f(xs,ys,i);
       case a[xs,ys] of
         -1:begin
              fire(a,xs,ys);i:=6;
            end;
         -2:begin
              electric(a,xs,ys,(xs*2-ys mod 2>x*2-y mod 2) xor ((xs*2-ys mod 2) in [0,mx-1]));i:=6;
            end;
         -3:begin
              water(a,xs,ys,w[xs,ys]);i:=6;
            end;
       end;
    end;
  end;
end.