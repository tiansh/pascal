unit comqpf;
interface
  uses
    types,variable,pdhp,dos,constant,prcot,crt,print;
 procedure countt(a:ba;num:byte;chty:byte;var average:real;var maxinum,mininum:byte);
implementation
  procedure countt(a:ba;num:byte;chty:byte;var average:real;var maxinum,mininum:byte);
    var
      b:ba;bb:tiao;al2:tiao;
      i,lastbak:zhang;
      j:byte;
      total:real;n,min,max,numb:longint;
      f1,f2,f3,f4,f5:boolean;
  begin
    lastbak:=last;
    al2:=al;
    for j:=1 to 14 do if j<>num then
     dec(al2[a[j].lb,a[j].sz],1);
    al2[huir.lb ,huir.sz ]:=round(sx/34);
    al2[huir2.lb,huir2.sz]:=round(sx/34);
    b:=a;total:=0;max:=0;min:=255;n:=0;
    for i.lb:=z to t do for i.sz:=1 to 9-2*ord(i.lb=z) do
     if al2[i.lb,i.sz]<>0 then begin
      b[num]:=i; last:=b[num];
      ba2tiao(b,bb,num);
      n:=n+(al2[i.lb,i.sz]);numb:=xz(bb,f1,f2,f3,f4,f5);
      if numb<2 then numb:=0;
      if numb>max then max:=numb;if numb<min then min:=numb;
      total:=total+numb;
    end;
    last:=lastbak;
    average:=total/n;
    maxinum:=max;mininum:=min;
  end;
end.