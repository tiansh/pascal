(*
˵����
�������³��������жϺ��ơ������Ҫ���е������½���checkhp.pas���������ǿ��������ļ��б������С�

program checkhp;
  uses
    pdhp,hpxs,print,constant,variable,types,
    ba2t,bmp,procfunc,graph,gramouse,comq;
  var
    i:byte;
    m,n:byte;
    b:tiao;
    mh,hd,zw,l,lb:boolean;
    f:text;
begin
  if paramcount>0 then assign(f,paramstr(1)) else assign(f,'');
  reset(f);
  readln(f,num[4]);
  for i:=1 to num[4] do begin
    read(f,m,n);
    sh[4,i].lb:=lei(m);
    sh[4,i].sz:=n;
  end;
  last:=sh[4,i];
  read(f,m,n);
  {huir}
  read(f,numhuir);
  close(f);
    huir[1].lb:=lei(m);huir[1].sz:=n;
    for i:=2 to numhuir do begin
      huir[i].lb:=huir[1].lb;
      huir[i].sz:=huir[i-1].sz+1;
      if huir[1].lb= z then if huir[i].sz=5  then huir[i].sz:=1;
      if huir[1].lb= z then if huir[i].sz=8  then huir[i].sz:=5;
      if huir[1].lb<>z then if huir[i].sz=10 then huir[i].sz:=1;
    end;
  {huir}
  ba2tiao(sh[4],b,num[4]);
  if not hupai(b) then write('0') else begin
    writeln(xz(b,mh,hd,zw,l,lb));
    writeln(mingming(mh,hd,zw,l,lb));
  end;
  readln;
end.
�����������ݹ�����ʹ�á�
˵����
�������������ʹ�õ�tiao���Ͷ������£�
    lei{��}=(z{��},w{��},b{��},t{��});{�Ƶ����}
    zhang{��}=record{��¼���ͣ����õķ���������object�ġ���������}
      lb{���}:lei;
      sz{����}:byte;{0��255������������}
    end;
    tl���������=array [1..9] of byte;{array������������������÷�����}
    tiao{��}=array [lei] of tl;
������������˵����Ӧ�Ķ���˵������һ�е����ݡ�
����exit;��ʾ�������˳���һ����(procedure)����(function)ֱ�ӻص��������ĵط���
������Pascal�к������ص�ֵ��ͨ����<������>��ֵ���صġ�
�����Ѿ�����ܵ��Ʋ����ڼ���֮�ڡ�
*)
unit PDHP{Panduan Hupai};
interface
  uses types, variable, constant, prcot, HPXS, ba2t;
  function hupai(a:tiao):boolean;
{���� �ж��Ƿ���ƣ���С��}
  function xz  (const a:tiao;var mh,hd,zw,l,lb:boolean):byte;
  function THxz(const a:tiao;var mh,hd,zw,l,lb:boolean):byte;
  function THsx(const a:tiao;var mh,hd,zw,l,lb:boolean):byte;
  function THsm(const a:tiao;var mh,hd,zw,l,lb:boolean):byte;
{
���� ѡ����Ժ͵������ƣ����غ��ƵĴ�С��
�ܿ�������������̵��жϷ�Χ֮�ڡ�
����ͬʱ���أ���mh,hd,zw,l,lb������ֱ�Ϊ��û������������׽����������������
}
  function mingming{����}(mh,hd,zw,l,bl:boolean):string;
{���غ��Ƶ����ƣ���Ӧ���ַ�����鿴��ͼƬ\��\���ж�Ӧ�ĺ���}
  function kyhu(num:byte;mh,hd,zw,l,bl,gp,dh:boolean):boolean;
{�����޻����ʱ���ӵĺ�����}
implementation
  function panduanl(a:tl;huir{���}:byte):boolean;
{
���жϡ��򡱡������������е�һ������
�ж��ܷ��ʾ�����ɸ�����ʽ��
����huir��ʾ�������ֻ�ɫ�����Ҳ���ʲô���ʵ����ʣ����Խ���һ���˿˵�˵�����Ļ����������
���õķ�����ö�ٿ��ܳɵĸ����ݹ��ж�����һ��������������ܷ��������Ҳ������ͨ��
}
    var
      i:byte;
      c:tl;{����}
      flag:boolean;
  begin
    flag:=true;
    for i:=1 to 9 do if a[i]<>0 then flag:=false;
    if flag then begin panduanl:=true; exit; end;
{���û������ô���ء�������}
    panduanl:=true;
    for i:=1 to 9 do if a[i]<>0 then begin
      if a[i]>=3 then begin c:=a;c[i]:=c[i]-3; if panduanl(c,huir) then exit; end;
{������һ����(AAA)}
      if (a[i] =2) and (huir>=1) then begin c:=a;c[i]:=c[i]-2; if panduanl(c,huir-1) then exit; end;
{������һ���ĺ�һ�Ż��(AAH)}
      if i<8 then
       if (a[i]<>0) and (a[i+1]<>0) and (a[i+2]<>0) then begin
        c:=a;dec(c[i]);dec(c[i+1]);dec(c[i+2]); if panduanl(c,huir) then exit;
        continue;
      end;
{������������(ABC)}
      if i<8 then
       if (a[i]<>0) and (a[i+2]<>0) and (huir>=1) then begin
        c:=a;dec(c[i]);dec(c[i+2]);if panduanl(c,huir-1) then exit;
      end;
{(AHC)}
      if i<9 then
       if (a[i]<>0) and (a[i+1]<>0) and (huir>=1) then begin
        c:=a;dec(c[i]);dec(c[i+1]);if panduanl(c,huir-1) then exit;
      end;
{(ABH)}
      if huir>=2 then begin
        c:=a;dec(c[i]);if panduanl(c,huir-2) then exit;
      end;
{(AHH)}
    end;
    panduanl:=false;
{
���������ζ����Ͳ�ͨ��ô���ء�����������
ע�⣡���������ǵݹ��������������ֻ�᷵�ص���һ�㡣
}
  end;
  function panduanz(a:tl;huir:byte):boolean;
{�ж����ƿɷ���ɸ�}
    var
      i,total:byte;
  begin
    total:=0;
    for i:=1 to 7 do
      total:=total+(3-((a[i]+2) mod 3+1));
    panduanz:=((huir-total)>=0) and ((huir-total) mod 3=0);
  end;
  function panduanf(a:tiao):boolean;
{���Ѿ��ѽ�ȥ��֮��ʣ�µ����ܷ�ȫ�����ɸ�}
    var
      total,cha,part:byte;
      l:lei;i:byte;
      nz,nw,nb,nt:byte;
    function num(const l:lei):byte;
{ͳ��ÿ�ֻ�ɫ���Ƶ�����}
      var
        i:byte;
        part:byte;
    begin
      part:=0;
      for i:=1 to 9-ord(l=z)*2 do part:=part+a[l,i];
      num:=part;
    end;
  begin
    if samehuir(last) then last:=bm;
    panduanf:=false;
    for nz:=0 to a[z,8] do
     for nw:=0 to a[z,8]-nz do
     for nb:=0 to a[z,8]-nw-nz do
     for nt:=0 to a[z,8]-nb-nw-nz do
     if nz+nw+nb+nt=a[z,8] then
      if (nz+num(z)) mod 3=0 then
      if (nw+num(w)) mod 3=0 then
      if (nb+num(b)) mod 3=0 then
      if (nt+num(t)) mod 3=0 then
      begin
{��ٷ�������ֻ�ɫ�Ļ����������Ҫ��ʹ����������䣬���ֻ�ɫ�Ƶ������������ı���}
        if panduanl(a[w],nw) and panduanl(a[b],nb) and panduanl(a[t],nt)
          and panduanz(a[z],nz) then begin
            numwbt[z]:=nz;numwbt[w]:=nw;numwbt[b]:=nb;numwbt[t]:=nt;
{�����Ǹ�HPXS��������ʾ���õ�}
            panduanf:=true; exit;
          end;
      end;
  end;
  function hupai(a:tiao):boolean;
    var
      jl:lei;jn:byte;
      c:tiao;
  begin
    if samehuir(last) then last:=bm;
    hupai:=false;
    for jl:=z to t do
     for jn:=1 to 9-ord(jl=z) do begin
{��ٽ������}
      if a[jl,jn]>=2 then begin
        c:=a;
        c[jl,jn]:=c[jl,jn]-2;
        jiang.lb:=jl;jiang.sz:=jn;
        if panduanf(c) then begin
         hupai:=true; exit; end;
      end else
        if (jl<>z) or (jn<>8) then
         if (a[jl,jn]=1) and (a[z,8]<>0) then begin
        c:=a;
        c[jl,jn]:=c[jl,jn]-1;c[z,8]:=c[z,8]-1;
        jiang.lb:=jl;jiang.sz:=jn;
        if panduanf(c) then begin hupai:=true; exit; end;
      end;
     end;
  end;
  function panduan(a:tiao;hd,zw,l:boolean;var lb:boolean):boolean;
{
�Ը�����hd,zw,l�ܷ����
hd,zw,l�ֱ��ʾ�������׽�������
��Ϊ���桱ʱ��Ҫ������������
�������׽�����˫�������׽���������׽��������ȵȡ�
lb��ʾ���Ƿ��Ǳ������������������Ǵ���ģ������жϺ󴫳��ġ�
�ڲ��ܺ����������lb��Զ����false��
�������ܺͱ��������
û������������Ҫ�жϡ�
�ܿ����жϲ�����������н���

�����˼·�ǣ�
���Ҫ�󵥻������ô��Ӧ�����㣺ȥ�����һ���ƺ�һ�Ż����������������ɸ���
���Ҫ��׽�����ô��Ӧ�����㣺���һ�������򣨻�����ȥ�����һ���ƺ��������һ���������Ժ��Ƶ��ͣ�С�ͣ���
���Ҫ������ô��Ӧ�����㣺ȥ��ĳ�ֻ�ɫ��������һ�ź���Ժ��Ƶ��͡�
�����������û���û�����档��̰��˼�룺ֻҪ�о�û��Ҫ�û����
ע�⣺׽���Ҫ��ȥ�������һ�š�����ȥ��������һ�š�������Ϊ������ץ�����ǻ����ô���ܵ��´���
}
    var
      i:byte;
      le:lei;
      b,c:tiao;
      flag,sh:boolean;
      hdp:zhang;
  begin
    if not l then lb:=false;{�����Ҫ��������ô�����������false}
    if samehuir(last) then last:=bm;
    if zw then if not (same(last,ww) or same(last,bm)) then
       begin panduan:=false; exit end;
{���Ҫ��׽��������ץ��һ���Ʋ���������߻����ôֱ����ֹ���̷���false}
    if zw and hd and (a[z,8]-ord(same(last,bm))<2) then begin panduan:=false; exit; end;
{���Ҫ��˫���������������������������ôֱ�ӷ���false}
   c:=a;
   for sh:=((not hd) or (a[z,8]-ord(same(last,bm))>1)) downto ((not hd) or (a[z,8]-ord(same(last,bm))=0) or zw) do begin
{
���Ҫ��������ôѭ����������������ж�˫������͵��������
����������������������ô���ж�˫�������
���ͬʱҪ��׽�������ȼ���˫����������ô���жϵ��������
}
    if hd and sh then huirdiao:=2 else if hd then huirdiao:=1 else huirdiao:=0;
{����Ǹ�HPXS�õ�}
    a:=c;
    if hd and (not zw) then begin
      dec(a[last.lb,last.sz]);
      if sh then dec(a[z,8],2) else dec(a[z,8],1);
    end;
{���Ҫ������û��Ҫ��׽�����ôȥ�����һ���ƺ�sh��Ӧ�Ļ��������}
    if zw then begin
      if hd then begin
{���Ҫ��˫��������ôȥ�����һ�ź����Ż��}
        dec(a[last.lb,last.sz]);
        dec(a[z,8],2);sh:=true;
      end else begin
{���ֻҪ��׽�����ôȥ�����һ�ź��������һ�š�}
        dec(a[last.lb,last.sz]);
        if a[w,4]<>0 then dec(a[w,4]) else if a[z,8]<>0 then dec(a[z,8]) else flag:=false;
        if a[w,6]<>0 then dec(a[w,6]) else if a[z,8]<>0 then dec(a[z,8]) else flag:=false;
      end;
    end else zhuowur:=false;
    if l then begin
{���Ҫ�������������жϡ���}
      b:=a;panduan:=false;
      if huir[1].lb<>z then begin
{���huir������ǡ��֡�����Ϊֻ�л���Ʋ����ֲ����п��ܺͱ������}
        loong:=huir[1].lb;
        lb:=true;
        le:=huir[1].lb;
        flag:=true;
        for i:=1 to 9 do if not ((not hd) and (zw) and (le=w) and (i in [4..6])) then begin
          if a[le,i]>0 then dec(a[le,i]) else if a[z,8]>0 then dec(a[z,8]) else flag:=false;
        end;
{��������ȥ��һ��}
        if flag then if sh then flag:=hupai(a) else flag:=panduanf(a);
        if flag then begin panduan:=true; exit; end;
{����ܺͱ��������ô�ͺͱ������}
      end;
      if (huir[1].lb=z) or not flag then
{�������Ĳ�������ôִ����Щ}
      for le:=w to t do if le<>huir[1].lb then begin
        loong:=le;
        a:=b;flag:=true;lb:=false;
        for i:=1 to 9 do if not ((zw) and (le=w) and (i in [4..6]) and (not hd)) then begin
          if a[le,i]>0 then dec(a[le,i]) else if a[z,8]>0 then dec(a[z,8]) else flag:=false;
        end;
{��������ȥ��һ��}
        if flag then if sh then flag:=hupai(a) else flag:=panduanf(a);
        if flag then begin panduan:=true; exit; end;
      end;
{���������ôֱ�Ӿ��˳���}
      a:=b;
    end else loong:=lei(0);
    if not l then begin
{���û��Ҫ������ô�������жϡ���}
      if sh then flag:=hupai(a) else flag:=panduanf(a);
      if flag then begin panduan:=true; exit end;
{���������ôֱ�Ӿ��˳���}
    end;
   end;
   panduan:=false;
{�������������ôֻ�ܷ���false}
  end;
  function xz(const a:tiao;var mh,hd,zw,l,lb:boolean):byte;
    var
      i:byte;
      n,max:byte;
      h,z,o,b:boolean;
      hh:byte; zz:boolean; oo:lei; jj:zhang;
  begin
    checkth:=false;
    if samehuir(last) then last:=bm;
    hd:=false;zw:=false;l:=false;lb:=false;mh:=a[lei(0),8]=0;
    meihuir:=mh;
    xz:=1; max:=1;
    hh:=0; zz:=false; oo:=lei(0); jj:=jiang; fillchar(baknum,sizeof(baknum),0);
    for i:=0 to 7 do begin
      h:=odd(i);z:=odd(i div 2);o:=odd(i div 4);n:=0;
{ѭ����ٻ����(h)׽���(z)��(o)}
      zhuowur:=z;huirdiao:=byte(h);loong:=lei(o);
      if panduan(a,h,z,o,b) then begin
{����ڶ�Ӧ��Ҫ���¿��Ժ���}
        n:=(3*ord(z)+4*ord(o))*(1+ord(o and b));
{����׽����Ƚ��м�����}    {�ٳ��Ա�������Ķ���}
        if n=0 then n:=1;
{���û��׽���������ô����С�ͣ�����Ϊ1}
        n:=n*(1+ord(h or mh));
{����л������û�����ô��Ӧ�ķ�������}
        n:=n*(1+ord(o and b and yqjyyyygh and subenlong))
{�����ر����������жϡ���yqjyyyygh�����ҽ���һ��һ�����}
      end;
      if n>=max then begin
{����õ��ķ�����֮ǰ�õ������ֵ����ô�滻ԭ����}
        max:=n;hd:=h;zw:=z;l:=o;lb:=b;
        hh:=huirdiao;zz:=zhuowur;oo:=loong;jj:=jiang;
        baknum:=numwbt;
      end;
    end;
    xz:=max;
    huirdiao:=hh;zhuowur:=zz;loong:=oo;jiang:=jj;
    numwbt:=baknum;
  end;
  function THsx(const a:tiao;var mh,hd,zw,l,lb:boolean):byte;
{��˳�����ͣ����������ƣ�����ϸ�����ˡ�}
    var
      i:byte;le:lei;
      max,n:byte;
      hh:byte; zz:boolean; oo:lei; jj:zhang;
      lp:zhang;
  begin
    meihuir:=a[lei(0),8]=0;
    if not hupai(a) then begin thsx:=0; exit; end;
    huirdiao:=0;zhuowur:=false;loong:=lei(0);jiang:=jj;max:=0;
    hh:=huirdiao; zz:=zhuowur; oo:=loong; jj:=jiang; lp:=last;
    for le:=z to t do for i:=1 to 9-ord(le=z) do if a[le,i]<>0 then begin
      last.lb:=le;last.sz:=i;
      n:=xz(a,mh,hd,zw,l,lb);
      if n>max then begin
        max:=n; hh:=huirdiao; zz:=zhuowur; oo:=loong; jj:=jiang; lp:=last;
      end;
    end;
    huirdiao:=hh; zhuowur:=zz; loong:=oo; jiang:=jj;
    mh:=meihuir;hd:=huirdiao<>0;zw:=zhuowur;l:=loong<>z;lb:=loong=huir[1].lb;
    last:=lp;
    THsx:=max;
  end;
  function THxz(const a:tiao;var mh,hd,zw,l,lb:boolean):byte;
{��˳�����ͣ����������ƣ�����ϸ�����ˡ�}
    var
      i:byte;
      n,max:byte;
      h,z,o,b:boolean;
      hh:byte; zz:boolean; oo:lei; jj:zhang;
  begin
    if samehuir(last) then last:=bm;
    hd:=false;zw:=false;l:=false;lb:=false;mh:=a[lei(0),8]=0;
    meihuir:=mh;
    THxz:=1; max:=1;
    hh:=0; zz:=false; oo:=lei(0); jj:=jiang; fillchar(baknum,sizeof(baknum),0);
    for i:=0 to 7 do begin
      h:=odd(i);z:=odd(i div 2);o:=odd(i div 4);n:=0;
      if z=true then continue;
      if h=true then continue;
      zhuowur:=z;huirdiao:=byte(h);loong:=lei(o);
      if panduan(a,h,z,o,b) then begin
        n:=(3*ord(z)+4*ord(o))*(1+ord(o and b));
        if n=0 then n:=1;
        n:=n*(1+ord(h or mh));
        n:=n*(1+ord(o and b and yqjyyyygh and subenlong))
      end;
      if n>=max then begin
        max:=n;hd:=h;zw:=z;l:=o;lb:=b;
        hh:=huirdiao;zz:=zhuowur;oo:=loong;jj:=jiang;
        baknum:=numwbt;
      end;
    end;
    THxz:=max;
    huirdiao:=hh;zhuowur:=zz;loong:=oo;jiang:=jj;
    numwbt:=baknum;
  end;
  function THsm(const a:tiao;var mh,hd,zw,l,lb:boolean):byte;
{����ܵĹ��̣����ݲ�ͬ�Ĺ����趨����������������}
  begin
    if tianhusuibianbai then
         thsm:=thsx(a,mh,hd,zw,l,lb)
    else thsm:=thxz(a,mh,hd,zw,l,lb);
    checkth:=true;
  end;
  function mingming{����}(mh,hd,zw,l,bl:boolean):string;
    var
      s:string;
  begin
    s:='';
    if mh then s:=s+'mhe' else
      if hd then if zw then s:=s+'she' else
      if huirdiao=1 then s:=s+'hei' else s:=s+'shei'
      else s:='';
    if zw then if (s='') or l then s:=s+'zwe' else s:=s+'we';
    if l then if bl then s:=s+'~hel' else s:=s+'l';
    if s[length(s)] in ['h','w'] then s:=s+'e';
    if subenlong then
      if bl and yqjyyyygh then if zw then s:='`~wl' else s:='`~l';
    mingming:=s;
    {���գ�mû h�� e�� s˫ i�� z׽ w�� ~�� l��}
  end;
  function kyhu(num:byte;mh,hd,zw,l,bl,gp,dh:boolean):boolean;
{���Ժ�}
  begin
    kyhu:=false; if num>=qihu then kyhu:=true;
    if qihu=3 then if num=2 then
     if not hd or gp or dh or zw then kyhu:=true
    else else else if gp then kyhu:=true;
  end;
end.