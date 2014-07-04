{$M 65500,0,655360}
(*
已知：
    自己是哪一家：n:byte {从左顺时针方向依次为1～4}
    自己的牌：sh[n]:array [1..14] of zhang; (其中：zhang=record)
    混儿牌是什么：huir, huir2:zhang;  (lb:lei; sz:byte; end;  lei=(z,w,b,t);)
    还剩下的牌的张数：sx:byte
    除去已经亮出的牌以外的牌：al:array [lei,1..9] of byte;
    现在是在碰杠之后还是一般情况chty{1:一般 2:碰 3:杠}

返回：
    要打出的是哪一张牌？(1～14) 或者要和牌(15)

可以使用的过程：
  function hupai(a:tiao):boolean;是否已经和牌？
  function xz(a:tiao;var mh,hd,zw,l,lb:boolean):byte;现在胡的是什么牌(多大)
  function mingming{42}(mh,hd,zw,l,bl:boolean):string;现在胡的是什么牌(参数由上面代入，字符串查看“图片\字\”)
  procedure ba2tiao(a:ba;var b:tiao; nu:byte);把sh[n]前nu个字符转化为tiao类型
  function same(a,b:zhang):boolean;判断两张牌是否一样

*)
unit comq;
interface
  uses
    types,variable,pdhp,dos,constant,prcot,print,CRT,comqpf,time;
  type
    numlt=array [1..9] of byte;
    iult=array [1..9] of real;
    bbt=array [lei] of numlt;
    iut=array [lei] of iult;
  var
    ltype:array [1..4] of lei;
    ltype_:array [1..4] of real;
  function inusel(b:numlt; var iu:iult; all:tl; lll:lei;flagb:boolean; n:byte):real;
  function comchose(const n,chty:byte):byte;
implementation
  var
    bb,bbbak,bbbbak:bbt;
    iub:iut;
    tj:array [0..4] of byte;
    n:byte;
  function power(a:real;b:byte):real;
  begin
    if b<>0 then
     if abs(a)<1E-3 then power:=0 else power:=exp(ln(a)*b)
    else power:=1.01;
  end;
  function inusel(b:numlt; var iu:iult; all:tl; lll:lei; flagb:boolean; n:byte):real;
    type
      topt=record
        scr:real; u:iult;
      end;
    var
      u:iult;al:tl;
      top:topt;
      tops:array [1..4] of topt;
      i:byte;num:byte;flag:boolean;
    function trunc0(n:integer):byte; begin if n<0 then trunc0:=0 else trunc0:=n end;
    function max(a,b:real):real; begin if a>b then max:=a else max:=b; end;
    procedure inuselt(m:byte;scr:real);
      var
        ubak:iult;
        bbak:numlt;
        scrd:real;
    begin
      checkkeyboard;
      if m=10 then begin
       if (round(scr/10)>top.scr/10)  or (flag and (round(scr/10)>=top.scr/10)) then
       begin top.scr:=round(scr); top.u:=u end end else
      {if b[m]=0 then inuselt(m+1,scr) else }begin
        {CASE INIT}
        ubak:=u; bbak:=b;
        {CASE 1}
        if b[m]<>0 then case b[m] of
         1,2:begin{CASE 1-2}
          u[m]:=u[m]+(226+2/3)/(power(0.9,tj[2])+1)*(power(al[m]/sx/13.2,trunc0(2-b[m])))+ord(ltype[n]<>z)*40;
          if b[m]<2 then b[m]:=0 else b[m]:=b[m]-2;
          inuselt(m,scr+(226+2/3)/power(0.9,tj[2])*(power(al[m]/sx/13.2,trunc0(3-b[m])))+ord(ltype[n]<>z)*40);
          b:=bbak;u:=ubak;
         end;
         3:begin{CASE 1-3}
          u[m]:=u[m]+549*power(al[m]/sx/13.2,trunc0(3-b[m]));
          if b[m]<3 then b[m]:=0 else b[m]:=b[m]-3;
          inuselt(m,scr+549*power(al[m]/sx/13.2,trunc0(3-b[m])));
          b:=bbak;u:=ubak;
         end;
         4:begin{CASE 1-4}
          u[m]:=u[m]+820*power(al[m]/sx/13.2,trunc0(4-b[m]));
          b[m]:=0;
          inuselt(m,scr+820*power(al[m]/sx/13.2,trunc0(3-b[m])));
          b:=bbak;u:=ubak;
         end;
        end;
        {CASE 2}
        if m in [1..7] then
         if (b[m+2]<>0) or (b[m]<>0) or (b[m+1]<>0) then begin
          scrd:=489*max(al[m+2]/sx/13.2,ord(b[m+2]>0))*
                    max(al[ m ]/sx/13.2,ord(b[ m ]>0))*
                    max(al[m+1]/sx/13.2,ord(b[m+1]>0));
          u[m+2]:=u[m+2]+scrd*(0.32);
          u[ m ]:=u[ m ]+scrd*(0.32);
          u[m+1]:=u[m+1]+scrd*(0.36);
          if b[m+2]<>0 then b[m+2]:=b[m+2]-1;
          if b[ m ]<>0 then b[ m ]:=b[ m ]-1;
          if b[m+1]<>0 then b[m+1]:=b[m+1]-1;
          inuselt(m,scr+scrd);
          b:=bbak;u:=ubak;
        end;
        {CASE 0}
          u[m]:=u[m]+b[m];
          inuselt(m+1,scr);
          u:=ubak;
        {CASE END}
      end;
    end;
  begin
    if lll=ltype[n] then begin
      for i:=1 to 9 do if bb[lll,i]<>0 then begin
        iub[lll,i]:=ltype_[n]*30*bb[lll,i];bb[lll,i]:=bb[lll,i]-1;
      end;
    end;
    for i:=1 to 9 do al[i]:=all[i]+bbbak[ltype[n],i]; u:=iu;
    flag:= true;top.scr:=-600;inuselt(1,0);tops[1]:=top;
    flag:=false;top.scr:=-600;inuselt(1,0);tops[2]:=top;
   if flagb then begin
    if lll=ltype[n] then begin
      b:=bbbak[lll];
      flag:= true;top.scr:=-600;inuselt(1,0);tops[3]:=top;
      flag:=false;top.scr:=-600;inuselt(1,0);tops[4]:=top;
    end;
    for i:=1 to 9 do if b[i]<>0 then iu[i]:=(tops[1].u[i]+tops[2].u[i])/b[i];
    if lll=ltype[n] then begin
      for i:=1 to 9 do if b[i]<>0 then
       iu[i]:=iu[i]*(0.9)+(tops[3].u[i]+tops[4].u[i])/b[i]*(0.1)
    end;
   end;
    inusel:=tops[1].scr+tops[2].scr;
  end;
  procedure inusez(b:numlt; var iu:iult; al:tl);
    var
      i:byte;
  begin
    for i:=1 to 7 do
      case b[i] of
        0:iu[i]:=0;
        1:iu[i]:=al[i]/sx/13.2*1E-50;
        2:iu[i]:=236+al[i]/sx/13.2-sx*1.3;
        3:iu[i]:=549+al[i]/sx/13.2;
        4:iu[i]:=1000;
      end
  end;
  procedure plus(var bb:bbt; var iub:iut;p:byte);
    var
      i:byte;
      li:lei;
      n,max:real;maxl:lei;
  begin
    iub[w,4]:=iub[w,4]+6;iub[w,6]:=iub[w,6]+6;
    max:=0;for li:=w to t do begin
      n:=0;for i:=1 to 9 do if bb[li,i]=1 then n:=n+1 else if bb[li,i]=2 then n:=n+0.93 else if bb[li,i]=4 then n:=n+1;
      if n>max then begin max:=n;maxl:=li; end;
    end;
    if (max+bb[z,8]>=5) then ltype[p]:=maxl else ltype[p]:=z;ltype_[p]:=max;
  end;
  function comchose(const n,chty:byte):byte;
    var
      b:tiao;
      li:lei;
      i,j:byte;
      min:real;np:byte;
      hpnr:byte;
  function hpn:byte;
    var
      c,d,e,f,g:boolean;
      i:byte;a:ba;
      max,min,numb:byte;maxmin,avg:real;
  begin
    hupnum:=0;
    if (hupai(b)) and (chty<>3) then begin
      hupnum:=xz(b,c,d,e,f,g);hupstr:=mingming(c,d,e,f,g);
      if chty=2 then begin hupnum:=2*hupnum; hupstr:='gk'+hupstr end;
    end;

  if (sx>8) and (chty<>2) then begin
    maxmin:=0;
    for i:=1 to num[n]-1 do begin
      a:=sh[n];swap(a[i],a[num[n]]);
      countt(a,num[n],chty,avg,max,min);
      if min>maxmin then begin
        maxmin:=min; numb:=i;
      end;
      if (avg>maxmin) and (avg-maxmin>(80-sx)/84) then begin
        maxmin:=avg; numb:=i;
      end;
      if (max>=maxmin*2) and (max-maxmin>(80-sx)/4.2) then begin
        maxmin:=max/1.5; numb:=i;
      end;
      iub[sh[n,i].lb,sh[n,i].sz]:=-(min*100+avg*sx*10+max)*b[sh[n,i].lb,sh[n,i].sz];
    end;
  end;

    if (hupnum>=2) then
     if (hupnum>=maxmin) or (sx<12) then hpn:=15 else hpn:=numb
    else hpn:=0;
  end;
  begin
    timein;
    comq.n:=n;checkkeyboard;
    if sx=0 then begin comchose:=14; exit; end;
    ba2tiao(sh[n],b,num[n]);hpnr:=hpn;
    if hpnr<>0 then begin
      comchose:=hpnr;sound(1044);delay(10);nosound;exit
    end;
    for li:=z to t do for i:=1 to 9-ord(li=z) do bb[li,i]:=b[li,i];
    fillchar(tj,sizeof(tj),0);
    fillchar(iub,sizeof(iub),0);bbbak:=bb;plus(bb,iub,n);bbbbak:=bb;{l,zw}
    for li:=z to t do for i:=1 to 9-2*ord(li=z) do inc(tj[b[li,i]]);
    for li:=w to t do inusel(bb[li],iub[li],al[li],li,true,n);inusez(bb[z],iub[z],al[li]);
    min:=1.7E+38;np:=num[n];
    for i:=1 to num[n] do if not (same(sh[n,i],huir) or same(sh[n,i],huir2)) then
     if iub[sh[n,i].lb,sh[n,i].sz]<min then begin
      min:=iub[sh[n,i].lb,sh[n,i].sz]; np:=i;
    end;
    comchose:=np;
    sound(1044);delay(10);nosound;
    timeout(10);{此处为卡时，单位ds}
  end;
end.