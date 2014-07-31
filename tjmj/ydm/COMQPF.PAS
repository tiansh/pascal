unit comqpf;
interface
  uses
    types,variable,pdhp,dos,constant,prcot,crt,print,ba2t;
 procedure countt(a:ba;num:byte;var average:real;var maxinum,mininum:byte);
implementation
  procedure countt(a:ba;num:byte;var average:real;var maxinum,mininum:byte);
    var
      b:ba;bb:tiao;
      al2:tiao2;
      i,lastbak:zhang;
      j:byte;
      total:real;n,min,max,numb:longint;
      f1,f2,f3,f4,f5:boolean;
  begin
    lastbak:=last;
    al2:=al;
    for j:=1 to 14 do if j<>num then
     dec(al2[a[j].lb,a[j].sz],1);
    for j:=1 to numhuir do
      al2[huir[j].lb,huir[j].sz]:=0;
    b:=a;total:=0;max:=0;min:=255;n:=0;

    for i.lb:=z to t do for i.sz:=1 to 9-2*ord(i.lb=z) do
     if al2[i.lb,i.sz]<>0 then begin
      b[num]:=i; last:=i;
      ba2tiao(b,bb,num);
      n:=n+(al2[i.lb,i.sz]);
      if hupai(bb) then begin
        numb:=xz(bb,f1,f2,f3,f4,f5);
        if not kyhu(numb,f1,f2,f3,f4,f5,false,false) then numb:=0;
      end else numb:=0;
      if numb>max then
        max:=numb;
        if numb<min then min:=numb;
      total:=total+numb*al2[i.lb,i.sz];
    end;

    last:=lastbak;
    if n=0 then average:=0 else average:=total/n;
    maxinum:=max;mininum:=min;
  end;
end.