(*
说明：
　　以下程序用来判断和牌。如果需要进行调试请新建“checkhp.pas”并将它们拷贝到该文件中保存运行。

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
　　以上内容供调试使用。
说明：
　　这个程序中使用的tiao类型定义如下：
    lei{类}=(z{字},w{万},b{饼},t{条});{牌的类别}
    zhang{张}=record{记录类型，引用的方法类似于object的“方法”等}
      lb{类别}:lei;
      sz{数字}:byte;{0～255的正整数类型}
    end;
    tl｛条－类｝=array [1..9] of byte;{array是数组的声明，引用用方括号}
    tiao{条}=array [lei] of tl;
　　以下所有说明对应的都是说明上面一行的内容。
　　exit;表示无条件退出这一过程(procedure)或函数(function)直接回到调用它的地方。
　　在Pascal中函数返回的值是通过给<函数名>赋值返回的。
　　已经碰或杠的牌并不在计算之内。
*)
unit PDHP{Panduan Hupai};
interface
  uses types, variable, constant, prcot, HPXS, ba2t;
  function hupai(a:tiao):boolean;
{函数 判断是否和牌，算小和}
  function xz  (const a:tiao;var mh,hd,zw,l,lb:boolean):byte;
  function THxz(const a:tiao;var mh,hd,zw,l,lb:boolean):byte;
  function THsx(const a:tiao;var mh,hd,zw,l,lb:boolean):byte;
  function THsm(const a:tiao;var mh,hd,zw,l,lb:boolean):byte;
{
函数 选择可以和的最大的牌，返回和牌的大小。
杠开并不在这个过程的判断范围之内。
另外同时返回：“mh,hd,zw,l,lb”含义分别为：没混儿，混儿吊，捉伍儿，龙，本混儿龙
}
  function mingming{命名}(mh,hd,zw,l,bl:boolean):string;
{返回和牌的名称，对应的字符串请查看“图片\汉\”中对应的汉字}
  function kyhu(num:byte;mh,hd,zw,l,bl,gp,dh:boolean):boolean;
{调试无混儿吊时增加的函数。}
implementation
  function panduanl(a:tl;huir{混儿}:byte):boolean;
{
（判断“万”“饼”“条”中的一个。）
判断能否表示成若干副的形式。
其中huir表示属于这种花色（我找不到什么合适的名词，所以借用一下扑克的说法）的混儿的数量。
采用的方法是枚举可能成的副并递归判断在这一副成立的情况下能否把其他的也都解释通。
}
    var
      i:byte;
      c:tl;{备份}
      flag:boolean;
  begin
    flag:=true;
    for i:=1 to 9 do if a[i]<>0 then flag:=false;
    if flag then begin panduanl:=true; exit; end;
{如果没有牌那么返回“成立”}
    panduanl:=true;
    for i:=1 to 9 do if a[i]<>0 then begin
      if a[i]>=3 then begin c:=a;c[i]:=c[i]-3; if panduanl(c,huir) then exit; end;
{有三张一样的(AAA)}
      if (a[i] =2) and (huir>=1) then begin c:=a;c[i]:=c[i]-2; if panduanl(c,huir-1) then exit; end;
{有两张一样的和一张混儿(AAH)}
      if i<8 then
       if (a[i]<>0) and (a[i+1]<>0) and (a[i+2]<>0) then begin
        c:=a;dec(c[i]);dec(c[i+1]);dec(c[i+2]); if panduanl(c,huir) then exit;
        continue;
      end;
{有连续的三张(ABC)}
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
如果无论如何都解释不通那么返回“不成立”。
注意！由于这里是递归如果“不成立”只会返回到上一层。
}
  end;
  function panduanz(a:tl;huir:byte):boolean;
{判断字牌可否组成副}
    var
      i,total:byte;
  begin
    total:=0;
    for i:=1 to 7 do
      total:=total+(3-((a[i]+2) mod 3+1));
    panduanz:=((huir-total)>=0) and ((huir-total) mod 3=0);
  end;
  function panduanf(a:tiao):boolean;
{在已经把将去掉之后剩下的牌能否全部构成副}
    var
      total,cha,part:byte;
      l:lei;i:byte;
      nz,nw,nb,nt:byte;
    function num(const l:lei):byte;
{统计每种花色的牌的张数}
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
{穷举分配给各种花色的混儿的数量，要求使混儿总量不变，各种花色牌的数量都是三的倍数}
        if panduanl(a[w],nw) and panduanl(a[b],nb) and panduanl(a[t],nt)
          and panduanz(a[z],nz) then begin
            numwbt[z]:=nz;numwbt[w]:=nw;numwbt[b]:=nb;numwbt[t]:=nt;
{这里是给HPXS（和牌显示）用的}
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
{穷举将的情况}
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
对给定的hd,zw,l能否和牌
hd,zw,l分别表示混儿吊、捉伍儿、龙
当为“真”时即要求满足条件。
混儿吊＋捉伍儿＝双混伍儿，捉伍儿＋龙＝捉伍儿龙，等等。
lb表示龙是否是本混儿龙，这个参数不是传入的，而是判断后传出的。
在不能和龙的情况下lb永远返回false。
龙尽可能和本混儿龙。
没混儿的情况不需要判断。
杠开的判断不再这个函数中进行

这里的思路是：
如果要求单混儿吊那么牌应当满足：去掉最后一张牌和一张混儿后其它都可以组成副。
如果要求捉伍儿那么牌应当满足：最后一张是伍万（或混儿）去掉最后一张牌和四六万各一张其它可以和推倒和（小和）。
如果要求龙那么牌应当满足：去掉某种花色１～９各一张后可以和推倒和。
如果有哪张牌没有用混儿代替。（贪心思想：只要有就没必要用混儿）
注意：捉伍儿要求去掉“最后一张”不是去掉“伍万一张”这是因为如果最后抓到的是混儿那么可能导致错误。
}
    var
      i:byte;
      le:lei;
      b,c:tiao;
      flag,sh:boolean;
      hdp:zhang;
  begin
    if not l then lb:=false;{如果不要求龙，那么本混儿龙返回false}
    if samehuir(last) then last:=bm;
    if zw then if not (same(last,ww) or same(last,bm)) then
       begin panduan:=false; exit end;
{如果要求捉伍儿而最后抓的一张牌不是伍万或者混儿那么直接终止过程返回false}
    if zw and hd and (a[z,8]-ord(same(last,bm))<2) then begin panduan:=false; exit; end;
{如果要求双混儿伍儿而混儿的数量不够两张那么直接返回false}
   c:=a;
   for sh:=((not hd) or (a[z,8]-ord(same(last,bm))>1)) downto ((not hd) or (a[z,8]-ord(same(last,bm))=0) or zw) do begin
{
如果要求混儿吊那么循环调用下面的内容判断双混儿吊和单混儿吊。
如果混儿的数量不足两张那么不判断双混儿吊。
如果同时要求捉伍儿（这等价于双混儿伍儿）那么不判断单混儿吊。
}
    if hd and sh then huirdiao:=2 else if hd then huirdiao:=1 else huirdiao:=0;
{这句是给HPXS用的}
    a:=c;
    if hd and (not zw) then begin
      dec(a[last.lb,last.sz]);
      if sh then dec(a[z,8],2) else dec(a[z,8],1);
    end;
{如果要求混儿吊没有要求捉伍儿那么去掉最后一张牌和sh对应的混儿的数量}
    if zw then begin
      if hd then begin
{如果要求双混儿伍儿那么去掉最后一张和两张混儿}
        dec(a[last.lb,last.sz]);
        dec(a[z,8],2);sh:=true;
      end else begin
{如果只要求捉伍儿那么去掉最后一张和四六万各一张。}
        dec(a[last.lb,last.sz]);
        if a[w,4]<>0 then dec(a[w,4]) else if a[z,8]<>0 then dec(a[z,8]) else flag:=false;
        if a[w,6]<>0 then dec(a[w,6]) else if a[z,8]<>0 then dec(a[z,8]) else flag:=false;
      end;
    end else zhuowur:=false;
    if l then begin
{如果要求龙进行如下判断……}
      b:=a;panduan:=false;
      if huir[1].lb<>z then begin
{如果huir的类别不是“字”，因为只有混儿牌不是字才能有可能和本混儿龙}
        loong:=huir[1].lb;
        lb:=true;
        le:=huir[1].lb;
        flag:=true;
        for i:=1 to 9 do if not ((not hd) and (zw) and (le=w) and (i in [4..6])) then begin
          if a[le,i]>0 then dec(a[le,i]) else if a[z,8]>0 then dec(a[z,8]) else flag:=false;
        end;
{１～９各去掉一张}
        if flag then if sh then flag:=hupai(a) else flag:=panduanf(a);
        if flag then begin panduan:=true; exit; end;
{如果能和本混儿龙那么就和本混儿龙}
      end;
      if (huir[1].lb=z) or not flag then
{如果上面的不成立那么执行这些}
      for le:=w to t do if le<>huir[1].lb then begin
        loong:=le;
        a:=b;flag:=true;lb:=false;
        for i:=1 to 9 do if not ((zw) and (le=w) and (i in [4..6]) and (not hd)) then begin
          if a[le,i]>0 then dec(a[le,i]) else if a[z,8]>0 then dec(a[z,8]) else flag:=false;
        end;
{１～９各去掉一张}
        if flag then if sh then flag:=hupai(a) else flag:=panduanf(a);
        if flag then begin panduan:=true; exit; end;
      end;
{如果成立那么直接就退出了}
      a:=b;
    end else loong:=lei(0);
    if not l then begin
{如果没有要求龙那么在这里判断……}
      if sh then flag:=hupai(a) else flag:=panduanf(a);
      if flag then begin panduan:=true; exit end;
{如果成立那么直接就退出了}
    end;
   end;
   panduan:=false;
{如果还不成立那么只能返回false}
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
{循环穷举混儿吊(h)捉伍儿(z)龙(o)}
      zhuowur:=z;huirdiao:=byte(h);loong:=lei(o);
      if panduan(a,h,z,o,b) then begin
{如果在对应的要求下可以和牌}
        n:=(3*ord(z)+4*ord(o))*(1+ord(o and b));
{龙和捉伍儿先进行加运算}    {再乘以本混儿龙的二倍}
        if n=0 then n:=1;
{如果没有捉伍儿或龙那么就是小和，分数为1}
        n:=n*(1+ord(h or mh));
{如果有混儿吊或没混儿那么对应的分数翻倍}
        n:=n*(1+ord(o and b and yqjyyyygh and subenlong))
{关于素本龙的特殊判断——yqjyyyygh：有且仅有一样一个混儿}
      end;
      if n>=max then begin
{如果得到的分数比之前得到的最大值大那么替换原来的}
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
{有顺序的天和，与上面类似，不详细介绍了。}
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
{无顺序的天和，与上面类似，不详细介绍了。}
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
{天和总的过程，根据不同的规则设定调用上面两个函数}
  begin
    if tianhusuibianbai then
         thsm:=thsx(a,mh,hd,zw,l,lb)
    else thsm:=thxz(a,mh,hd,zw,l,lb);
    checkth:=true;
  end;
  function mingming{命名}(mh,hd,zw,l,bl:boolean):string;
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
    {对照：m没 h混 e儿 s双 i吊 z捉 w伍 ~本 l龙}
  end;
  function kyhu(num:byte;mh,hd,zw,l,bl,gp,dh:boolean):boolean;
{可以和}
  begin
    kyhu:=false; if num>=qihu then kyhu:=true;
    if qihu=3 then if num=2 then
     if not hd or gp or dh or zw then kyhu:=true
    else else else if gp then kyhu:=true;
  end;
end.