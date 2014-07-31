{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R+,S+,T-,V+,X+,Y+}
{$M 65500,0,655360}

(*
ÒÑÖª£º
    ×Ô¼ºÊÇÄÄÒ»¼Ò£ºn:byte {´Ó×óË³Ê±Õë·½ÏòÒÀ´ÎÎª1¡«4}
    ×Ô¼ºµÄÅÆ£ºsh[n]:array [1..14] of zhang; (ÆäÖÐ£ºzhang=record)
    »ì¶ùÅÆÊÇÊ²Ã´£ºhuir:array [1..numhuir] of zhang;  (lb:lei; sz:byte; end;  lei=(z,w,b,t);)
    ÊÇ·ñÔÊÐíºÍÐ¡ºÍ£ºxiaohu_:boolean;
    »¹Ê£ÏÂµÄÅÆµÄÕÅÊý£ºsx:byte
    ³ýÈ¥ÒÑ¾­ÁÁ³öµÄÅÆÒÔÍâµÄÅÆ(ÊýÁ¿)£ºal:array [lei,1..9] of byte;
    ÏÖÔÚÊÇÔÚÅö¸ÜÖ®ºó»¹ÊÇÒ»°ãÇé¿öchty{1:Ò»°ã 2:Åö 3:¸Ü}

·µ»Ø£º
    Òª´ò³öµÄÊÇÄÄÒ»ÕÅÅÆ£¿(1¡«14) »òÕßÒªºÍÅÆ(15)

¿ÉÒÔÊ¹ÓÃµÄ¹ý³Ì£º
  function hupai(a:tiao):boolean;ÊÇ·ñÒÑ¾­ºÍÅÆ£¿
  function xz(a:tiao;var mh,hd,zw,l,lb:boolean):byte;ÏÖÔÚºÍµÄÊÇÊ²Ã´ÅÆ(¶à´ó£¬Ð¡ºÍ·µ»Ø1)
  function mingming{42}(mh,hd,zw,l,bl:boolean):string;ÏÖÔÚºÍµÄÊÇÊ²Ã´ÅÆ(²ÎÊýÓÉÉÏÃæ´úÈë£¬×Ö·û´®
²é¿´¡°Í¼Æ¬\×Ö\¡±£¬Ð¡ºÍ·µ»Ø¿Õ´®)
  procedure ba2tiao(a:ba;var b:tiao; nu:byte);°Ñsh[n]Ç°nu¸ö×ª»¯ÎªtiaoÀàÐÍ
  function same(a,b:zhang):boolean;ÅÐ¶ÏÁ½ÕÅÅÆÊÇ·ñÒ»Ñù
  procedure countt(a:ba;num:byte;chty:byte;var average:real;var maxinum,mininum:byte);Í³¼ÆÏÖÔÚ
ÌýÊ²Ã´ÅÆ£¨chtyÍ¬ÉÏ£¬average£º°´ÕÕal¡¢ÅÅ³ý»ì¶ùÅÆÒÔÍâÆ½¾ùºÍ¶à´óµÄÅÆ£¬maxinum, minnum£ºÄÜºÍµÄ×î´ó
ÖµÒÔ¼°×îÐ¡Öµ¡ª¡ª×îÐ¡ÖµÖ÷ÒªÍ³¼Æ»ì¶ùµõ*¡££©
*)

unit comq;
interface
  uses
    types,variable,pdhp,dos,constant,prcot,print,CRT,comqpf,time,ba2t,
    graph,hpxs;
  var
    loongtp:lei; loongnm:real;
    ltype :array [1..4] of lei;
    ltype_:array [1..4] of real;
    gang_ :array [1..4] of zhang;
    llt   :array [1..4] of lei;

    jshi:array [1..14] of string[20];

  function inusel(b:numlt; var iu:iult; all:tl2; lll:lei; numberp:byte; huirnum:byte; n:byte):real;
  function comchose(const n,chty:byte):byte;
implementation
  uses procfunc;
  var
    bb,bbbak:bbt;
    iub:iut;
    tj:array [0..4] of byte;
    n:byte;
  function power(a:real;b:real):real;
    var fout:text;
  begin
    if abs(b)>1E-20 then
     if abs(a)<1E-4 then power:=0 else power:=exp(ln(abs(a))*b)
    else power:=1;
  end;
  function inusel(b:numlt; var iu:iult; all:tl2; lll:lei; numberp:byte; huirnum:byte; n:byte):real;
    type
      topt=record
        scr:real; u:iult;
      end;
    var
      u:iult;al:iult;
      top,toppic,topbak,toppicbak:topt;topnum:byte;
      i,j:byte;num:byte;
      bbak:numlt;tot:byte;
    function trunc0(n:real):real; begin if n<0 then trunc0:=0 else trunc0:=n end;
    function max(a,b:real):real; begin if a>b then max:=a else max:=b; end;
    function min(a,b:real):real; begin if a<b then min:=a else min:=b; end;
    procedure inuselt(m:byte;const scr:real);
      function inusez(m:byte):real;
        var
          scrd:real;
      begin
        scrd:=183*al[m]/28*trunc0(al[m]-1)/28+10*trunc0(al[m]-2)/28*al[m]/28*trunc0(al[m]-1)/28;
        if m<=7 then scrd:=scrd+183*al[m+1]/28*al[m+2]/28;
        if (m<=8) and (m>=2) then scrd:=scrd+183*al[m+1]/28*al[m-1]/28;
        if m>=3 then scrd:=scrd+183*al[m-1]/28*al[m-2]/28;
        if lll=llt[n] then scrd:=scrd+ltype_[n];
        inusez:=scrd;
      end;
      var
        ubak :iult; bbak :numlt;
        ubak2:iult; bbak2:numlt;
        scrd,scrd2,scrda,scrdb,scrdz:real;
        i,j,k:shortint;
        case2:boolean;
        pn:byte;
    begin
      checkkeyboard;
      while (m<10) and (b[m]=0) do inc(m);
      if m=10 then begin
        if scr>top.scr then begin top.scr:=scr; top.u:=u; topnum:=1; end;
        if scr=top.scr then begin
          for i:=1 to 9 do top.u[i]:=(top.u[i]*topnum+u[i])/(topnum+1);
          topnum:=topnum+1;
        end;
        for i:=1 to 9 do if u[i]>toppic.u[i] then toppic.u[i]:=u[i];
      end else begin
        {CASE INIT}
        ubak:=u; bbak:=b;
        {CASE 1}
        if b[m]<>0 then begin
         if b[m]=1 then begin{CASE 1-1 A}
           scrd:=inusez(m);
           u[m]:=min(u[m],scrd);b[m]:=0;
           inuselt(m,scr+scrd);
           b:=bbak;u:=ubak;
         end;
         if b[m]=2 then begin{CASE 1-2 AA}
          scrd:=((113)/(power(1.12,tj[2]))+ord(ltype[n]<>z)*12)*power(1.3,al[m])*0.6;
          if qihu=3 then scrd:=scrd+8; if qihu=3 then if huirnum<>0 then begin
           if tj[2]=1 then scrd:=scrd+ord(numberp=5)*110+50
          end else begin
           if tj[2]=1 then scrd:=scrd+ord(numberp=5)*20+10
          end;
          scrd:=scrd+inusez(m)*0.52;
          u[m]:=min( u[m], scrd );
          b[m]:=0;
          inuselt(m, scr+scrd*2);
          b:=bbak;u:=ubak;
         end;
         if b[m]=3 then begin{CASE 1-3 AAA}
          u[m]:=min( u[m], 183+ord(qihu=3)*20+inusez(m)*0.24 );
          b[m]:=0;
          inuselt(m,scr+(183+ord(qihu=3)*20)*3);
          b:=bbak;u:=ubak;
         end;
         if b[m]=4 then begin{CASE 1-4 AAAA}
          u[m]:=min( u[m], 205+inusez(m)*0.12 );
          b[m]:=0;
          inuselt(m,scr+205*4);
          b:=bbak;u:=ubak;
         end;
        end;
        {CASE 2 AB A0C}
        if m in [1..8] then
         if (ord(b[m+1]<>0)+ord(b[round(min(m+2,9))]<>0))>0 then begin
          scrd:=183*3;
          if m=1 then scrd:=scrd*max(al[m+2]/28,ord(b[m+2]>0))
           else if m=8 then scrd:=scrd*max(al[m-1]/28,ord(b[m-1]>0))
           else scrd:=scrd*max((al[m+2]+al[m-1])/28,ord(b[m+2]>0));
          scrd:=scrd*max(al[m+1]/28,ord(b[m+1]>0));
          if m<=7 then case2:=(b[m+1]<>0) and (b[m+2]<>0) else case2:=false;
          if case2 then begin
            u[m+2]:=min(u[m+2],scrd*(0.34)+inusez(m+2)*0.48);
            u[ m ]:=min(u[ m ],scrd*(0.34)+inusez( m )*0.48);
            u[m+1]:=min(u[m+1],scrd*(0.34)+inusez(m+1)*0.48);
            scrd:=3*0.38*scrd;
          end else if b[m+1]=0 then begin
            u[m+2]:=min(u[m+2],scrd*(0.33)+inusez(m+2)*0.48);
            u[ m ]:=min(u[ m ],scrd*(0.33)+inusez( m )*0.48);
            scrd:=scrd*0.66;
          end else begin
            u[ m ]:=min(u[ m ],scrd*(0.33)+inusez( m )*0.48);
            u[m+1]:=min(u[m+1],scrd*(0.33)+inusez(m+1)*0.48);
            scrd:=scrd*0.66;
          end;
          if m<=7 then if b[m+2]<>0 then b[m+2]:=b[m+2]-1;
          if b[m+1]<>0 then b[m+1]:=b[m+1]-1;
          b[m]:=b[m]-1;
          inuselt(m,scr+scrd);
          if case2 and (b[m+1]+b[m+2]+b[m]>0) then begin
          {Case 2+}
            bbak2:=b;ubak2:=u;u:=ubak;
            {Case 2+1 AABC}
            if b[m]>1 then begin
              scrd2:=183*al[m]/28*trunc0(al[m]-1)/28+10*trunc0(al[m]-2)/28*al[m]/28*trunc0(al[m]-1)/28;
              if m<=7 then scrd2:=scrd2+183*al[m+1]/28*al[m+2]/28;
              if (m<=8) and (m>=2) then scrd2:=scrd2+183*al[m+1]/28*al[m-1]/28;
              if m>=3 then scrd2:=scrd2+183*al[m-1]/28*al[m-2]/28;
              if m<=6 then scrd2:=scrd2+183*al[m+3]/28*al[m]/28;
              u[m]:=min(min(u[m],scrd),scrd2);b[m]:=b[m]-1;
              u[m+1]:=ubak2[m+1]; u[m+2]:=ubak2[m+2];
              inuselt(m,scr+scrd+scrd2);
              b:=bbak2;u:=ubak;
            end;
            {Case 2+2 ABBC}
            pn:=m+1; if pn<=9 then
            if (b[pn]>1) then begin
              scrd2:=183*al[pn]/28*trunc0(al[pn]/28)+10*trunc0(al[m]-2)/28*al[pn]/28*trunc0(al[pn]/28);
              if pn<=7 then scrd2:=scrd2+183*al[pn+1]/28*al[pn+2]/28;
              if (pn<=8) and (pn>=2) then scrd2:=scrd2+183*al[pn+1]/28*al[pn-1]/28;
              if pn>=3 then scrd2:=scrd2+183*al[pn-1]/28*al[pn-2]/28;
              if pn>=4 then scrd2:=scrd2+183*al[pn-3]/28*al[pn]/28;
              if (pn<=7) and (pn>=3) then scrd2:=scrd2+183*al[pn-2]/28*al[pn+2]/28;
              u[pn]:=min(min(u[pn],scrd),scrd2);b[pn]:=b[pn]-1;
              u[m]:=ubak2[m]; u[m+2]:=ubak2[m+2];
              inuselt(m,scr+scrd+scrd2);
              b:=bbak2;u:=ubak2;
            end;
            {Case 2+3 ABCC}
            pn:=m+2; if pn<=9 then
            if b[pn]>1 then begin
              scrd2:=183*al[pn]/28*trunc0(al[pn]/28)+10*trunc0(al[m]-2)/28*al[pn]/28*trunc0(al[pn]/28);
              if pn<=7 then scrd2:=scrd2+183*al[pn+1]/28*al[pn+2]/28;
              if (pn<=8) and (pn>=2) then scrd2:=scrd2+183*al[pn+1]/28*al[pn-1]/28;
              if pn>=3 then scrd2:=scrd2+183*al[pn-1]/28*al[pn-2]/28;
              if pn>=4 then scrd2:=scrd2+183*al[pn-3]/28*al[pn]/28;
              u[pn]:=min(min(u[pn],scrd),scrd2);b[pn]:=b[pn]-1;
              u[m]:=ubak2[m]; u[m+1]:=ubak2[m+1];
              inuselt(m,scr+scrd+scrd2);
              b:=bbak2;u:=ubak2;
            end;
          end;
          b:=bbak;u:=ubak;
        end;
        {CASE 3}(* = {CASE 1-2} & {CASE2}*)
        if (b[m]=2) then begin
          {CASE 3-1 A0CC AA0C ABB AAB}
          for i:=-1 to 1 do for j:=1 to 2 do
           if i<>0 then
           if (m+i*(3-j)>0) and (m+i*(3-j)<=9) then
           if (m+j*i>0) and (m+i*j<=9) then
           if b[m+j*i]>0 then if b[m+i*(3-j)]=0 then begin
            {From: CASE 1-2 AA/CC/BB}
            scrd:=((113)/(power(1.12,tj[2]+1))+ord(ltype[n]<>z)*12)*power(1.3,al[m])*0.6;
            if qihu=3 then scrd:=scrd+8; if qihu=3 then if huirnum<>0 then begin
             if tj[2]=0 then scrd:=scrd+ord(numberp=5)*110+50
            end else begin
             if tj[2]=0 then scrd:=scrd+ord(numberp=5)*20+10
            end;
            {From: CASE 2 A0C/A0B}
            scrd2:=183*3*al[m+i*(3-j)]/28;
            u[m+i*j]:=min(u[m+i*j],scrd2*(0.33));
            u[  m  ]:=min(u[  m  ],scrd2*(0.33));
            scrd2:=scrd2*0.56;
            u[m]:=min( u[m], scrd );
            b[m]:=0;dec(b[m+i*j]);
            inuselt(m, scr+scrd*2+scrd2);
            b:=bbak;u:=ubak;
          end;
        end;
        {CASE 4}
        {CASE 4-4 ABCD}
        if m<7 then if b[m]*b[m+1]*b[m+2]*b[m+3]<>0 then begin
          scrd:=183*3;
          {B}u[m+1]:=min(u[m+1],scrd*0.34+inusez(m+1));
          {C}u[m+2]:=min(u[m+2],scrd*0.34+inusez(m+2));
          {A}
           scrd2:=182*al[m]/28*trunc0(al[m]-1)/28+10*trunc0(al[m]-2)/28*al[m]/28*trunc0(al[m]-1)/28;
           if m<=7 then scrd2:=scrd2+182*al[m+1]/28*al[m+2]/28;
           if (m<=8) and (m>=2) then scrd2:=scrd2+182*al[m+1]/28*al[m-1]/28;
           if m>=3 then scrd2:=scrd2+182*al[m-1]/28*al[m-2]/28;
           if (m<6) and (m>1) then scrd2:=scrd2+al[m-1]/28*al[m+4]/28;
           scrd2:=scrd2+inusez(m)*0.48;
           u[m]:=min(u[m],scrd2);
           scrda:=scrd2;
          {D}
           scrd2:=182*al[m+3]/28*trunc0(al[m+3]-1)/28+10*trunc0(al[m+3]-2)/28*al[m+3]/28*trunc0(al[m+3]-1)/28;
           if m<=4 then scrd2:=scrd2+182*al[m+4]/28*al[m+5]/28;
           if (m<=5) and (m>=5) then scrd2:=scrd2+182*al[m+4]/28*al[m+2]/28;
           scrd2:=scrd2+182*al[m+2]/28*al[m+1]/28;
           if (m<6) and (m>1) then scrd2:=scrd2+al[m-1]/28*al[m+4]/28;
           u[m+3]:=min(u[m+3],scrd2);
           scrd2:=scrd2+inusez(m)*0.48;
           scrdb:=scrd2;
          dec(b[m]);dec(b[m+1]);dec(b[m+2]);dec(b[m+3]);
          scrdz:=inusez(m)+inusez(m+1)+inusez(m+2)+inusez(m+3);
          inuselt(m, scr+scrd+max(scrda,scrdb)+scrdz);
          b:=bbak;u:=ubak;
        end;
        {CASE 4-5 ABCDE}
        if m<6 then if b[m]*b[m+1]*b[m+2]*b[m+3]*b[m+4]<>0 then
         if b[m]+b[m+4]=2 then begin
          scrd:=183*3;
          {B}u[m+1]:=min(u[m+1],scrd*0.34+inusez(m+1));
          {C}u[m+2]:=min(u[m+2],scrd*0.34+inusez(m+2));
          {D}u[m+3]:=min(u[m+3],scrd*0.34+inusez(m+3));
          scrd2:=182*al[m+2]/28;
          if m<>1 then scrd2:=scrd2+182*al[m-1]/28;
          if m<>5 then scrd2:=scrd2+182*al[m+5]/28;
          scrda:=183*al[ m ]/28*trunc0(al[ m ]-1)/28+10*trunc0(al[ m ]-2)/28*al[ m ]/28*trunc0(al[ m ]-1)/28;
          scrdb:=183*al[m+4]/28*trunc0(al[m+4]-1)/28+10*trunc0(al[m+4]-2)/20*al[m+4]/28*trunc0(al[m+4]-1)/28;
          u[ m ]:=min(u[ m ],scrd2+scrda+inusez( m ));
          u[m+4]:=min(u[m+4],scrd2+scrdb+inusez(m+4));
          dec(b[m]);dec(b[m+1]);dec(b[m+2]);dec(b[m+3]);dec(b[m+4]);
          scrdz:=inusez(m)+inusez(m+1)+inusez(m+2)+inusez(m+3)+inusez(m+4);
          inuselt(m,scr+scrd+scrd2*2+scrda+scrdb+scrdz);
          b:=bbak;u:=ubak;
        end;
        {CASE 5 124,689}
        if lll<>w then begin
          {CASE 5-1 124}
          if m=1 then if (b[1]<>0) and (b[2]<>0) and (b[4]<>0) then begin
            scrd:=183*3*max(al[m+2]/28,ord(b[m+2]>0))*0.99;
            u[2]:=min(u[2],scrd/3+inusez(2));
            if inusez(1)>inusez(4) then begin
              u[1]:=min(u[1],scrd/3*0.94+inusez(1));
              u[4]:=min(u[4],scrd/3*0.12+inusez(4));
            end else begin
              u[4]:=min(u[4],scrd/3*0.94+inusez(4));
              u[1]:=min(u[1],scrd/3*0.12+inusez(1));
            end;
            scrdz:=inusez(1)+inusez(2)+inusez(4);
            dec(b[1]);dec(b[2]);dec(b[4]);
            inuselt(m,scr+scrd*2/3+scrdz);
            b:=bbak;u:=ubak;
          end;
          {CASE 5-2 689}
          if m=6 then if (b[6]<>0) and (b[8]<>0) and (b[9]<>0) then begin
            scrd:=183*3*max(al[m+1]/28,ord(b[m+1]>0))*0.99;
            u[8]:=min(u[8],scrd/3+inusez(8));
            if inusez(9)>inusez(6) then begin
              u[6]:=min(u[6],scrd/3*0.94+inusez(6));
              u[9]:=min(u[9],scrd/3*0.12+inusez(9));
            end else begin
              u[9]:=min(u[9],scrd/3*0.94+inusez(9));
              u[6]:=min(u[6],scrd/3*0.12+inusez(6));
            end;
            scrdz:=inusez(6)+inusez(8)+inusez(9);
            dec(b[6]);dec(b[8]);dec(b[9]);
            inuselt(m,scr+scrd*1.06+scrdz);
            b:=bbak;u:=ubak;
          end;
        end;
        {CASE 6 A0C0E}
        if m<6 then if (b[m]*b[m+2]*b[m+4]>0) and (b[m+1]+b[m+3]=0) then begin
          scrda:=183*0.99*al[m+1]/28;
          scrdb:=183*0.99*al[m+3]/28;
          u[ m ]:=min(u[ m ],scrda+inusez(m));
          u[m+4]:=min(u[m+4],scrdb+inusez(m+4));
          u[m+2]:=min(u[m+2],max(scrda,scrdb)+inusez(m+2));
          dec(b[m]);dec(b[m+2]);dec(b[m+4]);
          scrdz:=inusez(m)+inusez(m+2)+inusez(m+4);
          inuselt(m,scr+scrda+scrdb+max(scrda,scrdb)+scrdz);
          b:=bbak;u:=ubak;
        end;
        {CASE END}
      end;
    end;
    procedure countal;
      var
        useful:iult;
        i:byte;
        fout:text;
    begin
      for i:=1 to 9 do al[i]:=all[i]-b[i];
      for i:=1 to 9 do begin
        useful[i]:=183*power(al[i]/28,2);
        if i<=7 then useful[i]:=useful[i]+183*al[i+1]/28*al[i+2]/28;
        if (i<=8) and (i>=2) then useful[i]:=useful[i]+183*al[i+1]/28*al[i-1]/28;
        if i>=3 then useful[i]:=useful[i]+183*al[i-1]/28*al[i-2]/28;
      end;
      for i:=1 to 9 do al[i]:=al[i]*power(0.94,sqr(useful[i]/10));
    end;
  begin
    for i:=1 to 9 do u[i]:=0;bbak:=b;
    tot:=0;for i:=1 to 9 do tot:=tot+b[i];
    if lll=ltype[n] then begin
      for i:=1 to 9 do if b[i]<>0 then begin
        u[i]:=ltype_[n]*15.2;b[i]:=b[i]-1;
      end;
    end else for i:=1 to 9 do u[i]:=1E30;
    countal;
    top.scr:=-1E20;
    for i:=1 to 9 do toppic.u[i]:=-1E20;
    topnum:=0;inuselt(1,0);
    for i:=1 to 9 do if bbak[i]<>0 then begin
      iu[i]:=iu[i]+top.u[i]+toppic.u[i]/50+random/100;
      if tot=1 then continue;
    end;
    inusel:=top.scr;
  end;
  procedure inusez(b:numlt; var iu:iult; al:tl2);
    function trunc0(n:real):real; begin if n<0 then trunc0:=0 else trunc0:=n end;
    var
      i:byte;
  begin
    for i:=1 to 7 do
      case b[i] of
        0:iu[i]:=0;
        1:iu[i]:=iu[i]+182*al[i]/28*trunc0(al[i]-1)/28+10*trunc0(al[i]-2)/28*al[i]/28*trunc0(al[i]-1)/28;
        2:iu[i]:=iu[i]+182*al[i]/20+10*trunc0(al[i]-1)/18*al[i]/20;
        3:iu[i]:=iu[i]+549+al[i]/sx/18+sx*0.2;
        4:iu[i]:=iu[i]+1000;
      end
  end;
  procedure plus(var bb:bbt; var iub:iut; p:byte);
    var
      i,m,mj,mm:byte; li:lei;
      j,f:zhang;
      n,max:real;maxl:lei;
  begin
   {long}
    max:=0;for li:=w to t do begin
      n:=0;for i:=1 to 9 do if bb[li,i]=1 then n:=n+1
                       else if bb[li,i]=2 then n:=n+0.94
                       else if bb[li,i]=3 then n:=n+0.98
                       else if bb[li,i]=4 then n:=n+1;
      if bb[z,8]<>0 then n:=n+bb[z,8]*1.08 else n:=n+0.04;
      if li=huir[1].lb then n:=n-2.6;
      if ltype[p]=li then n:=n+0.6;
      if qihu=3 then n:=n*1.1 else if qihu=1 then n:=n*0.94;

      bbbak:=bb;
      mm:=0;for j.lb:=z to t do for j.sz:=1 to 9-ord(j.lb=z) do begin
        bb:=bbbak;
        for i:=1 to 9 do if bb[li,i]<>0 then dec(bb[li,i]);
        mj:=0;if not same(j,bm) then
         if bb[j.lb,j.sz]>1 then begin
          dec(bb[j.lb,j.sz]);
          mj:=1;
        end;
        m:=0;for f.lb:=z to t do for f.sz:=1 to 9-2*ord(f.lb=z) do begin
          if f.lb<>z then
            if (f.sz<>1) and (f.sz<7) then
            if bb[f.lb,f.sz]*bb[f.lb,f.sz+1]<>0 then begin
              if m=0 then m:=1;
              if bb[f.lb,f.sz+2]<>0 then m:=2;
            end;
          if bb[f.lb,f.sz]>2 then m:=2 else
           if bb[f.lb,f.sz]=2 then m:=1;
        end;
        if m+mj>mm then mm:=m+mj;
      end;
      bb:=bbbak;
      n:=n+mm;
      if n>max then begin max:=n;maxl:=li; end;
    end;
    if num[p]<11 then maxl:=z; loongtp:=maxl; loongnm:=max;
    if (maxl<>z) and (max>=13.94-sx/18) then ltype[p]:=maxl else
    if (maxl<>z) and (max>=11.82-sx/18+(p mod 4-2)*0.26) then llt[p]:=maxl else
    begin llt[p]:=z; ltype[p]:=z; end;
    ltype_[p]:=max;
   {zhuowur}
    if ltype[p]<>z then
    if (not ((huir[1].lb=w) and (huir[1].sz in [6-numhuir..6]))) then begin
      iub[w,4]:=iub[w,4]+10+4*qihu;iub[w,6]:=iub[w,6]+10+4*qihu;
      if bb[z,8]<>0 then begin iub[w,4]:=iub[w,4]+6; iub[w,6]:=iub[w,6]+6 end;
      if qihu=3 then if num[p]<11 then begin iub[w,4]:=iub[w,4]+26; iub[w,6]:=iub[w,6]+26 end;
    end else begin
      iub[w,4]:=iub[w,4]+5+2*qihu;iub[w,6]:=iub[w,6]+5+2*qihu;
      if bb[z,8]<>0 then begin iub[w,4]:=iub[w,4]+3; iub[w,6]:=iub[w,6]+3 end;
      if qihu=3 then if num[p]<11 then begin iub[w,4]:=iub[w,4]+26; iub[w,6]:=iub[w,6]+26 end;
    end else begin
      iub[w,4]:=iub[w,4]+5+2*qihu;iub[w,6]:=iub[w,6]+5+2*qihu;
    end;
   {minggang}
    if num[p]<14 then
      for i:=num[p]+1 to 14 do
       if sh[p,i].lb<=t then
        iub[sh[p,i].lb,sh[p,i].sz]:=iub[sh[p,i].lb,sh[p,i].sz]-30;
   {danger}
    for li:=z to t do for i:=1 to 9-2*ord(li=z) do
     if (al[li,i]=4) and (bb[li,i]=1) then
      if li=z then iub[li,i]:=iub[li,i]+6.2
      else if i=9 then iub[li,i]:=iub[li,i]+5.4-(al[li,i-1]*al[li,i-2])*0.015
      else if i=8 then iub[li,i]:=iub[li,i]+5.4-(al[li,i-1]*al[li,i-2]+al[li,i-2]*al[li,i+1])*0.015
      else if i=1 then iub[li,i]:=iub[li,i]+5.4-(al[li,i+1]*al[li,i+2])*0.015
      else if i=2 then iub[li,i]:=iub[li,i]+5.4-(al[li,i+1]*al[li,i+2]+al[li,i+1]*al[li,i-1])*0.015
      else  iub[li,i]:=iub[li,i]+5.4-(al[li,i+1]*al[li,i+2]+al[li,i+1]*al[li,i-1]+al[li,i-1]*al[li,i-2])*0.015;
   {mid}
    for li:=w to t do for i:=1 to 9 do
     iub[li,i]:=iub[li,i]+(4-abs(i-5))*0.1;
  end;
  function comchose(const n,chty:byte):byte;
    var
      b:tiao;
      li:lei;
      i,j:byte;
      min:real;np:byte;
      hpnr:byte;
  function hpn:byte;
    const hpl:array [1..3,1..3,0..6] of real=(
      (( 179.5,-354.6, 237.8,-55.80, 1.959,-1.884, 0.842),
       (-53.41,-59.81, 138.0,-55.86, 2.804,-1.209, 0.968),
       ( 657.9,-1053 , 626.9,-166.3, 20.39,-2.866, 0.590) ),
      ((-57.10,-135.9, 251.3,-109.6, 10.90,-1.142, 0.993),
       (-969.7, 1450 ,-732.0, 146.2,-15.89, 0.575, 0.991),
       ( 59.33,-128.2, 76.11,-2.815,-5.773,-1.264, 0.753) ),
      ((-949.2, 1399 ,-685.1, 126.5,-12.29, 0.371, 0.994),
       (-2256 , 2838 ,-1744 , 461.8,-55.16, 2.350, 1    ),
       (-427.2, 558.1,-253.7, 61.91,-14.05,-0.157, 0.955) ));
    function hplf(sx:byte):real;
      var
        x,y:real;
        i:byte;
    begin
      x:=sx/(alast);y:=hpl[numhuir,qihu,0];
      for i:=1 to 6 do y:=y*x+hpl[numhuir,qihu,i];
      if y>1 then y:=1 else if y<0 then y:=0;
      hplf:=y;
    end;
    function tnl(sx:byte):real;
      var t:real;
    begin
      t:=(1-hplf(sx-1))/(1-hplf(sx));
      if t>0.99 then tnl:=0.99;
      tnl:=t;
    end;
    const ave:array [1..3,1..3] of real=(
      (1.88426038706185, 1.54209472981988, 1.71711711711712),
      (2.52825226469729, 1.72651818702191, 3.31800038015586),
      (2.91447885552586, 2.01626432577420, 4.62325581395349));
    var
      c,d,e,f,g:boolean;
      i:byte;a:ba;
      max,min,numb:byte;
      maxmin,maxmin0,avg:real;
      tt:real;
      hh:byte; zz:boolean; oo:lei; jj:zhang; mm:boolean;
  begin
    hupnum:=0;
    if (hupai(b)) and (chty<>3) then begin
      if tianhu then
        hupnum:=thsm(b,c,d,e,f,g)
      else hupnum:=xz(b,c,d,e,f,g);
      hh:=huirdiao;zz:=zhuowur;oo:=loong;jj:=jiang;mm:=meihuir;
      hupstr:=mingming(c,d,e,f,g);
      if kyhu(hupnum,c,d,e,f,g,chty=2,dihu[n]) then begin
       if chty=2 then begin hupnum:=2*hupnum; hupstr:='gk'+hupstr end;
            if dihu[n] then begin
              if daxiaobeishu=0 then begin
                if tianhu then begin
                  if hupnum<tianhubeishu then
                    begin hupnum:=tianhubeishu;hupstr:='tu' end
                    else hupstr:='tu'+hupstr;
                end else begin
                  if hupnum<dihubeishu then
                    begin hupnum:=dihubeishu;hupstr:='0u' end
                    else hupstr:='0u'+hupstr;
                end
              end;
              if daxiaobeishu=1 then begin
                if tianhu then begin
                   hupstr:='tu'+hupstr; hupnum:=hupnum*tianhubeishu;
                 end else begin{tianhu}
                   hupstr:='0u'+hupstr; hupnum:=hupnum*dihubeishu;
                 end
              end;
              if daxiaobeishu=2 then begin
                if tianhu then begin
                   hupstr:='tu'+hupstr; hupnum:=hupnum+tianhubeishu;
                 end else begin{tianhu}
                   hupstr:='0u'+hupstr; hupnum:=hupnum+dihubeishu;
                 end
              end;
            end;
      end else hupnum:=0;
    end;

    if hupnum>0 then maxmin0:=hupnum
     else maxmin0:=-(1-tnl(sx))*ave[numhuir,qihu];
    maxmin:=maxmin0; numb:=0;

    for i:=1 to num[n] do if not samehuir(sh[n,i]) then begin
      a:=sh[n];swap(a[i],a[num[n]]);
      countt(a,num[n],avg,max,min);
      tt:=tnl(sx);
      if tt*avg-(1-tt)*ave[numhuir,qihu]>maxmin then begin
        maxmin:=tt*avg-(1-tt)*ave[numhuir,qihu];
        numb:=i;
      end;
      iub[sh[n,i].lb,sh[n,i].sz]:=(maxmin0-(tt*avg-(1-tt)*ave[numhuir,qihu]))*1E5*power(2,qihu);
    end;
    if (hupnum>0.01) and
      ((hupnum+0.06>=maxmin) or (sx<=12)) then begin
        hpn:=15;huirdiao:=hh;zhuowur:=zz;loong:=oo;jiang:=jj;meihuir:=mm;
    end else hpn:=numb;
  end;
    label 1;
    var
      c,d,e,f,g:boolean;
  begin
1:  timein;randomize;
    if (n=4) and debugcomq then begin
      moveto(140,460);setcolor(black);for i:=1 to 47 do outtext('Û');
      moveto(140,468);setcolor(black);for i:=1 to 47 do outtext('Û');
    end;
    comq.n:=n;checkkeyboard;
    if sx=0 then begin comchose:=14; exit; end;
    for li:=z to t do for i:=1 to 9-ord(li=z) do iub[li,i]:=0;
    ba2tiao(sh[n],b,num[n]);hpnr:=hpn;
    if hpnr=15 then begin
      comchose:=hpnr;
      if soundp then sound(1044);delay(10);nosound;exit
    end;
    for li:=z to t do for i:=1 to 9-ord(li=z) do bb[li,i]:=b[li,i];
    fillchar(tj,sizeof(tj),0);
    plus(bb,iub,n);{l,zw}
    for li:=z to t do for i:=1 to 9-2*ord(li=z) do inc(tj[b[li,i]]);
    for li:=w to t do inusel(bb[li],iub[li],al[li],li,num[n],bb[z,8],n);inusez(bb[z],iub[z],al[z]);
    min:=1.7E+38;np:=num[n];
    for i:=1 to num[n] do if not (samehuir(sh[n,i])) then
     if iub[sh[n,i].lb,sh[n,i].sz]+random/100<min then begin
      min:=iub[sh[n,i].lb,sh[n,i].sz]+random/100; np:=i;
    end;

 if (n=4) and debugcomq then begin
    moveto(140,460);setcolor(black);for i:=1 to 47 do outtext('Û');
    moveto(140,468);setcolor(black);for i:=1 to 47 do outtext('Û');
    for i:=1 to num[n] do begin
      moveto(140+(i-1)*width+width*(i div num[4]),460+8*(i mod 2));
      setcolor(lightblue);
      if sh[n,i].lb=ltype[4] then setcolor(lightgreen);
      if sh[n,i].lb=z then setcolor(lightgray);
      if i=np then setcolor(lightred);
      if iub[sh[n,i].lb,sh[n,i].sz]<0 then begin
        if i<>np then setcolor(white);
        outtext('TING');
      end else
      if samehuir(sh[n,i]) then begin
        setcolor(white);
        outtext('Hur!');
      end else
      outtext(inttostr(round((iub[sh[n,i].lb,sh[n,i].sz])*10)));
    end;
  end;

    if num[n]<14 then begin
      for i:=num[n]+1 to 14 do if same(sh[n,i],sh[n,np]) then break;
      if same(sh[n,i],sh[n,np]) then begin
        minggang(n,sh[n,np]); goto 1
      end;
    end;
    comchose:=np;
    if debugger=(n=4) then timeout(delaytime);{´Ë´¦Îª¿¨Ê±£¬µ¥Î»ds}
    if not debugger and debugcomq then if soundp then sound(1044);delay(10);nosound;
  end;
end.