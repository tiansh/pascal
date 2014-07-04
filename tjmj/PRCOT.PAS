unit PrCoT;
interface
  uses types,variable,constant,print,graph,crt;
  procedure gotlastpic(n:byte);
  procedure px(var a:ba;n:byte);
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
  procedure px(var a:ba;n:byte);
    var
      i,j:byte;
      n1,n2:integer;
  begin
    for i:=1 to n-1 do for j:=i+1 to n do begin
      n1:=10+ord(a[i].lb)*10-a[i].sz;
      n2:=10+ord(a[j].lb)*10-a[j].sz;
      if same(a[i],huir) then n1:=100 else if same(a[i],huir2) then n1:=99;
      if same(a[j],huir) then n2:=100 else if same(a[j],huir2) then n2:=99;
      if same(a[i], cl ) then n1:= 0 ;     if same(a[j], cl  ) then n2:=0;
      if same(a[i], kb ) then n1:= 0 ;     if same(a[j], kb  ) then n2:=0;
      if n1<n2 then swap(a[i],a[j]);
    end;
  end;
  procedure gotlastpic(n:byte);
  begin
    printsx(2);
    ggang(sh[n,num[n]]);
    last:=sh[n,num[n]];
    if (last.lb=huir.lb) and (last.sz in [huir.sz,huir2.sz]) then begin
      last.lb:=z;last.sz:=8;
    end;
    printb(sh[n,num[n]],n,num[n]+1,n=4);
    if sx>20 then printsx(15) else printsx(12);
  end;
end.