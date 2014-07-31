unit PrCoT;
interface
  uses types,variable,constant,crt,graph,print;
  procedure gotlastpic(n:byte);
  procedure px(var a:ba;n:byte);
  procedure pgpx(var a:ba;n:byte;z:zhang);
  procedure swap(var a,b:zhang);
  procedure reprint(n:byte);
  procedure done;
  procedure CheckKeyboard;
implementation
  procedure CheckKeyboard;
  begin
   if keypressed then case readkey of
     #27:done;#0:if readkey in [#107,#45] then done;
   end;
  end;
  procedure done;
  begin
    closegraph;nosound;writeln('');halt(0);
  end;
  procedure reprint(n:byte);
    var
      i:byte;
  begin
    px(sh[n],num[n]);
    for i:=1 to num[n]-1 do
    printb(sh[n,i],n,ord(i<num[n])*i+ord(i>num[n])*(2.4+num[n]+0.75*(i-num[n])+
            0.4*((i-num[n]-1)div 3)),(n=4) or (i>num[n]));
  end;
  procedure swap(var a,b:zhang); var t:zhang;begin t:=a;a:=b;b:=t end;
  procedure pgpx(var a:ba;n:byte;z:zhang);
    var
      i,j:byte;
  begin
    for i:=1 to n do for j:=i+1 to n do
     if same(a[i],z) and not same(a[j],z) then swap(a[i],a[j]);
  end;
  procedure px(var a:ba;n:byte);
    var
      i,j,k:byte;
      n1,n2:integer;
  begin
    for i:=1 to n-1 do for j:=i+1 to n do begin
      n1:=10+ord(a[i].lb)*10-a[i].sz;
      n2:=10+ord(a[j].lb)*10-a[j].sz;
      for k:=1 to numhuir do begin
        if same(a[i],huir[k]) then n1:=100-k;
        if same(a[j],huir[k]) then n2:=100-k;
      end;
      if same(a[i],cl) then n1:=0;if same(a[j],cl) then n2:=0;
      if same(a[i],kb) then n1:=0;if same(a[j],kb) then n2:=0;
      if n1<n2 then swap(a[i],a[j]);
    end;
  end;
  procedure ggang(var a:zhang);
  begin
    if (sx=0) and (gangn<ahuir) then gangn:=ahuir;
    a:=variable.a[gangn]; dec(gangn);
    if gangn=ahuir then dec(gangn);
    if gangn<alast then alast:=gangn;
  end;
  procedure gotlastpic(n:byte);
  begin
    printsx(2);
    ggang(sh[n,num[n]]);
    last:=sh[n,num[n]];
    if samehuir(last) then begin
      last.lb:=z;last.sz:=8;
    end;
    printb(sh[n,num[n]],n,num[n]+1,n=4);
    if sx>20 then printsx(15) else printsx(12);
  end;
end.