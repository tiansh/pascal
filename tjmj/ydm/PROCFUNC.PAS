unit procfunc;
interface
  uses
    Types, Constant, Variable, bmp, bmp2b, bmp16b, Graph, DOS, GraMouse, RuleSet,
    Print, PDHP, Drivers, CRT, ComQ, PrCoT, HPXS, Ba2T, FilExist;
  procedure cmd(command:string);
  procedure initj;
  procedure init;
  procedure minit;
  procedure run;
  procedure win(n:byte);
  procedure huangp;
  procedure checkexit;
  procedure minggang(n:byte;gz:zhang);
implementation
  procedure cmd(command:string);
  begin
    Command := '/C ' + Command;
    SwapVectors;
    Exec(GetEnv('COMSPEC'), Command);
    SwapVectors;
  end;
  procedure minit;
    var
      i:byte;
  begin
    for i:=1 to 4 do score[i]:=250;
    d:=random(4)+1;
    lun:=1;dong:=random(4)+1;nzhuang:=1;
    runexit:=false;
    numzhuang:=0;
  end;
  function zhuangs(n:byte):boolean;
  begin
    zhuangs:=(dong+nzhuang-2) mod 4+1=n
  end;
  procedure scorep(n,num:byte;zuozhuang:boolean);
    var i:byte;
  begin
    printscore(2);
    if zuozhuang then
      if zhuangs(n) then begin
        inc(score[n],num*8);for i:=1 to 4 do dec(score[i],num*2);
      end else begin
        inc(score[n],num*5);for i:=1 to 4 do dec(score[i],num* ( 1+ord(zhuangs(i)) ));
      end
    else begin
      inc(score[n],num*4);for i:=1 to 4 do dec(score[i],num);
    end;
    printscore(15);
  end;
  procedure init;
  begin
    clrscr;
    inigraph;
    printinit;
    graphmouseinit;
    ruleinit;
  end;
  procedure gotpic(var zh:zhang;n:byte);
    var i:byte;
  begin
    printsx(2);
    last:=a[anum];anum:=anum+1;
    zh:=last;
    if samehuir(last) then begin
      last.lb:=z;last.sz:=8;
    end;
    printb(sh[n,num[n]],n,num[n]+1,n=4);
    if tianhu then begin
      px(sh[n],14);
      for i:=1 to 14 do
        printb(sh[n,i],n,i+ord(i=14),n=4);
    end;
    if sx>20 then printsx(15) else printsx(12);
  end;
  procedure angang(n:byte;gz:zhang);
    var
      i,j:byte;
  begin
        {An Gang}
      if nogradeb then write('A');
      if soundp then begin sound(1746);delay(200);nosound; end;
      pgpx(sh[n],num[n],gz);
      inc(sh[n,num[n]-2].lb,8);
      inc(sh[n,num[n]-1].lb,4);
      inc(sh[n, num[n] ].lb,8);
      dec(num[n],3);
      sh[n,num[n]].lb:=lei(0);
      sh[n,num[n]].sz:=0;
      px(sh[n],num[n]-1);
      gotlastpic(n);
      clearb(n);
      for i:=1 to 14 do
       printb(sh[n,i],n,ord(i<=num[n])*i+ord(i=num[n])+ord(i>num[n])*(2.4+num[n]+0.75*(i-num[n])+
            0.4*((i-num[n]-1)div 3)),(n=4) or (i>num[n]));
      if not samehuir(gz) then scorep(n,2,false) else scorep(n,huirgangnum,false);
      kggz:=true; if (n mod 4=(dong+nzhuang-1) mod 4) then zjkg:=true;
        {An Gang}
      pgl:=true;
  end;
  procedure minggang(n:byte;gz:zhang); {xiao}
    var
      i,j:byte;
  begin
    if nogradeb then write('m');
    if soundp then begin sound(1746);delay(200);nosound end; checkkeyboard;
      {Ming Gang}
    pgpx(sh[n],num[n],gz);
    for i:=num[n]+1 to 14 do if same(sh[n,i],gz) then break;
    inc(sh[n,i+1].lb,4);
    sh[n,num[n]].lb:=lei(0);
    sh[n,num[n]].sz:=0;
    px(sh[n],num[n]-1);
    gotlastpic(n);
    clearb(n);
    for i:=1 to 14 do
     printb(sh[n,i],n,ord(i<=num[n])*i+ord(i=num[n])+ord(i>num[n])*(2.4+num[n]+0.75*(i-num[n])+
          0.4*((i-num[n]-1)div 3)),(n=4) or (i>num[n]));
    scorep(n,1,false);
    kggz:=true; if (n mod 4=(dong+nzhuang-1) mod 4) then zjkg:=true;
    printz;
      {Ming Gang}
    pgl:=true;
  end;
  function choose(n,chty:byte):boolean; forward;
  function inpchose(var a:ba;chty:byte):shortint;
    label 1;
    var                             {1:Simple, 2:Gang, 3:Peng}
      event:tevent;
      flag,hu,gang:boolean;
      b:tiao;
      c,d,e,f,g:boolean;
      i,j,k,u,hunum:byte;
      z:zhang;
    function userg2:boolean;
      var
        b:tiao;
        i,j,k,n,ic:byte;
        gz:zhang;
        flag:boolean;
    begin
      ba2tiao(a,b,14);
      n:=0;userg2:=false;
      for i:=0 to 3 do
       for j:=1 to 9-ord(i=0)*2 do
       if b[lei(i),j]=4 then begin
        inc(n);gz.lb:=lei(i);gz.sz:=j;
       end;
      if huirgangnum<>0 then for i:=1 to numhuir do begin
        k:=0; for j:=1 to num[4] do if same(a[j],huir[i]) then k:=k+1;
        if k=4 then begin inc(n); gz:=huir[i]; b[huir[i].lb,huir[i].sz]:=4; end;
      end;
      if n<>1 then begin
        bmp16(tupian+'\'+xuanze+'.bmp',110,getmaxy-13,16,4);
        flag:=false;
        begin
          mouseinput(event,1);if runexit then exit;
          if keypressed then event.where.y:=90;
          case event.where.y of
            54..57:begin
             if event.where.x in
              [18..14+3*num[4]] then begin
                ic:=(event.where.x-15) div 3;
                flag:=true;
              end else if event.where.x in
              [18+3*num[4]..20+3*num[4]] then begin
                ic:=n;
                flag:=true;
              end
            end;
          end;
          gz:=sh[4,ic];
          flag:=flag and (b[sh[4,ic].lb,sh[4,ic].sz]=4);
          setcolor(green);setfillstyle(1,2);bar(0,getmaxy-13,545,getmaxy);
          if not flag then exit;
        end;
      end;
      al[gz.lb,gz.sz]:=0;
      ba2tiao(a,b,num[4]);
      if huirgangnum<>0 then for i:=1 to numhuir do begin
        k:=0; for j:=1 to num[4] do if same(a[j],huir[i]) then k:=k+1;
        if k=4 then begin inc(n); b[huir[i].lb,huir[i].sz]:=4; end;
      end;
      if b[gz.lb,gz.sz]=4 then begin
        AnGang(4,gz);
        userg2:=true;
      end else begin
        MingGang(4,gz);
        userg2:=true;
      end;
    end;
  begin
1:
   if debugger or debugcomq then comchose(4,chty);

    flag:=false;gang:=false;hu:=false;
    if runexit then exit;
    if chty<>3 then begin
      ba2tiao(a,b,14);
      for i:=0 to 3 do
       for j:=1 to 9-2*ord(i=0) do
        if b[lei(i),j]=4 then gang:=true;
      if huirgangnum<>0 then for i:=1 to numhuir do begin
        k:=0; for j:=1 to num[4] do if same(a[j],huir[i]) then k:=k+1;
        if k=4 then gang:=true;
      end;
      ba2tiao(a,b,num[4]);
      if not xiangg then
        if hupai(b) then begin
          hunum:=xz(b,c,d,e,f,g);
          hu:=kyhu(hunum,c,d,e,f,g,chty=2,dihu[4])
        end else hu:=false;
    end;
    printform(false,gang,hu,false);
    repeat
      mouseinput(event,1);if runexit then exit;
      if keypressed then event.where.y:=90;
      case event.where.y of
        54..57:begin
         if event.where.x in
          [18..14+3*num[4]] then begin
            inpchose:=(event.where.x-15) div 3;
            flag:=true;
          end else if event.where.x in
          [18+3*num[4]..20+3*num[4]] then begin
            inpchose:=num[4];
            flag:=true;
          end
        end;
        50..52:case event.where.x of
          21..23:if hu then begin
            inpchose:=0;
            if tianhu then hupnum:=thsm(b,c,d,e,f,g) else hupnum:=xz(b,c,d,e,f,g);
            hupstr:=mingming(c,d,e,f,g); if chty=2 then begin hupnum:=2*hupnum; hupstr:='gk'+hupstr end;
            if dihu[4] then begin
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
            inpchose:=15; exit;
          end;
          18..20:if gang then begin
            u:=0;
            if userg2 then begin
              tianhu:=false; dihu[4]:=false;
              chty:=2;goto 1;
            end;
          end;
        end;
      end;
    until flag;
    printform(false,false,false,false);
    if soundp then sound(1044);delay(10);nosound;
  end;
 procedure CPpeng(n:byte);
   var
     i,j:byte;
 begin
   if nogradeb then write('P');
   if soundp then begin sound(4176);delay(200);nosound end; checkkeyboard;
   dec(thr[(zhua-1)mod 4+1]);
   printthr(cl,(zhua-1)mod 4+1);
   j:=0;sh[n,num[n]]:=throwout;
   for i:=1 to num[n]-3 do
     if same(sh[n,i],throwout) then begin
       swap(sh[n,i],sh[n,num[n]-j]);inc(j);dec(i);
       if j>2 then break;
     end;
   num[n]:=num[n]-3;
   px(sh[n],num[n]);
   clearb(n);
   printscore(15);printz;
   for i:=1 to 14 do
    printb(sh[n,i],n,ord(i<=num[n])*i+ord(i=num[n])+ord(i>num[n])*(2.4+num[n]+0.75*(i-num[n])+
         0.4*((i-num[n]-1)div 3)),(n=4) or (i>num[n]));
   choose(n,3);
   lun:=(4+n-dong) mod 4+1;dec(al[throwout.lb,throwout.sz],2);
 end;
  procedure CPgang(n:byte){Da Ming};
    var
      i,j:byte;
  begin
    if nogradeb then write('M');
    if soundp then begin sound(1746);delay(200);nosound end; checkkeyboard;
     dec(thr[(zhua-1)mod 4+1]);
     printthr(cl,(zhua-1)mod 4+1);
    sh[n,num[n]]:=throwout;
    pgpx(sh[n],num[n],throwout);
    inc(sh[n,num[n]-1].lb,4);dec(num[n],3);
    sh[n,num[n]].lb:=lei(0);sh[n,num[n]].sz:=0;
    px(sh[n],num[n]-1);
    gotlastpic(n);
    clearb(n);
    for i:=1 to 14 do
     printb(sh[n,i],n,ord(i<=num[n])*i+ord(i=num[n])+ord(i>num[n])*(2.4+num[n]+0.75*(i-num[n])+
          0.4*((i-num[n]-1)div 3)),(n=4) or (i>num[n]));
    scorep(n,1,false);
    kggz:=true; if (n mod 4=(dong+nzhuang-1) mod 4) then zjkg:=true;
    printz;
    choose(n,2);
    lun:=(4+n-dong) mod 4+1;al[throwout.lb,throwout.sz]:=0;
    pgl:=true;
  end;
  function compg(var a:ba;numb,n:byte):byte;
    label 1;
    var
      ba,b:numlt;
      bb:tiao;
      i,j,l:byte;
      iu:iult; all:tl2; lll:lei;
      n1,n2:real;
  begin
    ba2tiao(a,bb,num[n-1]);
    if throwout.lb=z then begin
      if boolean(numb and 1) then
        if (ltype_[n]<8) or (num[n]=14) or (sx<25) then cpgang(n) else begin end
      else if boolean(numb and 2) then cppeng(n);
      exit;
    end;
    fillchar(b,sizeof(b),0);fillchar(iu,0,sizeof(iu));a[num[n]]:=throwout;
    for i:=1 to num[n] do if lei(byte(a[i].lb) mod 4)=throwout.lb then inc(b[a[i].sz]);
    all:=al[throwout.lb];
    n1:=inusel(b,iu,all,lll,n,bb[lei(0),8],n);ba:=b;
    if boolean(numb and 1) then begin {Gang}
      b:=ba; b[throwout.sz]:=0;
      for l:=1 to 9 do iu[l]:=0;
      all[throwout.sz]:=0;
      n2:=inusel(b,iu,all,lll,n,bb[z,8],n)+205*4+100;
      if (ltype[n]<>z) and (num[n]=11) then n2:=n2-round(100*loongnm*sx/50);
      if n2>n1 then CPGang(n) else goto 1;
    end else if boolean(numb and 2) then begin {Peng}
1:    b:=ba; dec(b[throwout.sz],3);
      for l:=1 to 9 do iu[l]:=0;
      dec(all[throwout.sz],2);
      n2:=inusel(b,iu,all,lll,n,bb[z,8],n)+183*3+20;
      if (ltype[n]<>z) and (num[n]=11) then n2:=n2-round(100*loongnm*sx/50);
      if n2>n1 then begin CPPeng(n); pgl:=true; end;
    end;
    dec(b[throwout.sz],3);
  a[num[n]]:=cl;
  end;
  function comgang(n:byte):boolean;
    var
      a:ba;c:tiao;b:numlt;
      i,j,k,l:byte;
      n1,n2:real;
      iu:iult; all:tl2; lll:lei;
      gz:zhang;
      hu:boolean;
      d,e,f,g,h:boolean;
  begin
    comgang:=false;
    a:=sh[n];
    ba2tiao(a,c,14);
    inc(c[z,8]);hu:=hupai(c);
    for j:=1 to 7 do
     if c[z,j]=4 then begin
       gz.lb:=z;gz.sz:=j;
       a:=sh[n];fillchar(b,sizeof(b),0);
       for k:=1 to num[n] do if a[k].lb=gz.lb then inc(b[a[k].sz]);
       if b[j]<>4 then MingGang(n,gz) else AnGang(n,gz);comgang:=true;
    end;
    for i:=1 to 3 do
     for j:=1 to 9 do
     if c[lei(i),j]=4 then begin
      gz.lb:=lei(i);gz.sz:=j;
      a:=sh[n];fillchar(b,sizeof(b),0);
      for k:=1 to num[n] do if a[k].lb=gz.lb then inc(b[a[k].sz]);
      for l:=1 to 9 do iu[l]:=0;
      all:=al[gz.lb];
      n1:=inusel(b,iu,all,gz.lb,n,c[z,8],n);
      k:=b[gz.sz];b[gz.sz]:=0;
      for l:=1 to 9 do iu[l]:=0;
      all[gz.sz]:=0;
      n2:=inusel(b,iu,all,gz.lb,n,c[z,8],n)+690*ord(k>=4)+210;
      if (n2>n1) then begin
        if k<4 then MingGang(n,gz) else AnGang(n,gz); comgang:=true;
      end;
    end;
    if huirgangnum<>0 then for i:=1 to numhuir do begin
      k:=0; for j:=1 to num[4] do if same(a[j],huir[i]) then k:=k+1;
      if k=4 then if not hu then angang(n,huir[i]) else
        if xz(c,d,e,f,g,h)<huirgangnum-3 then angang(n,huir[i]);
    end;
  end;
  function choose(n,chty:byte):boolean;
    var
      t,i,j,u:byte;
      l:zhang;
      flag:boolean;
      event:tevent;
  begin
    choose:=false;
    if (n=4) and not debugger then begin
      repeat
        t:=inpchose(sh[n],chty);
        if runexit then exit;
        if t=15 then break;
      until (not (samehuir(sh[4,t]))) or xiangg_;
      if t<>15 then
       if samehuir(sh[4,t]) then begin
        xiangg:=true;
        bmp2(tupian+'\'+han+'\xg.bmp',118+113,398+ 4,8+7,4);
      end;
      tianhu:=false; dihu[4]:=false;
    end else begin
      if (chty=3) then t:=comchose(n,3)
        else if dihu[n] then t:=comchose(n,1)
        else t:=comchose(n,1+ord(comgang(n)));
      tianhu:=false; dihu[n]:=false;
    end;
    if t=15 then begin
      win(n);choose:=true;gkhl:=true;exit;
    end;
    l:=sh[n,t];throwout:=l;
    printthr(sh[n,t],n);inc(thr[n]);
    bmp16(tupian+'\'+wbt[sh[n,t].lb]+'\'+inttostr(sh[n,t].sz)+'.bmp',358,255,13,4);
    for i:=1 to 4 do bmp2(tupian+'\'+han+'\'+dnxb[(4+i-dong) mod 4]+'.bmp',284,272,2,4);
    bmp2(tupian+'\'+han+'\'+dnxb[(4+n-dong) mod 4]+'.bmp',284,272,15,4);
    sh[n,t]:=sh[n,num[n]];
    sh[n,num[n]].lb:=z;sh[n,num[n]].sz:=9;
    reprint(n);
    printb(cl,n,num[n]+1,true);
  end;
  function ablepg(n:byte):byte;
    var
      i,j:byte;
      b:tiao;
  begin
    j:=0;if samehuir(throwout) then begin ablepg:=0; exit; end;
    ba2tiao(sh[n],b,num[n]-1);
    for i:=1 to num[n]-1 do
     if same(sh[n,i],throwout)
       then inc(j);
    ablepg:=(ord(j>=2)*2+ord(j=3))*ord(b[z,8]+j<>num[n]-1);
    if (sx=0) and not xiangg_ then ablepg:=0;
  end;
  procedure nptpg(numb:byte);
    var
      event:tevent;eve:char;
      flag:boolean;
  begin
    if soundp then begin sound(1044);delay(80);sound(1273);delay(120); end; nosound;
    printform(numb and 2<>0,numb and 1<>0,false,true);
    repeat
      mouseinput(event,1);if runexit then exit;
      flag:=false;
      if event.where.y in [50..52] then
        if event.where.x in [15..17] then eve:='p' else
         if event.where.x in [18..20] then eve:='g' else
         if event.where.x in [24..28] then eve:='c'
        else eve:='2'
      else eve:='1';
      if eve='p' then begin if numb and 2<>0 then {userp}cppeng(4) else eve:='3' end
       else if eve='g' then begin if numb and 1<>0 then CPgang(4) else eve:='3' end;
      if eve in ['p','g'] then flag:=true;
      if eve='c' then begin
        printp(cl,(getmaxx-15*width) div 2+((num[4]+2)-1)*width,getmaxy-py-height,4,true);
        printform(false,false,false,false);pgl:=false;exit;
      end;
    until flag;
    printform(false,false,false,false);
  end;
  procedure rp(var a:tao);
    var
      r:byte;
      i,j,k:byte; bb:real; l:lei;
      b:array [1..136] of real;
  begin;
    randomize;
    j:=0;for l:=z to t do for i:=1 to 7+2*ord(l<>z) do for k:=1 to 4 do begin
      j:=j+1; a[j].lb:=l; a[j].sz:=i; end;
    for r:=1 to 8 do begin
      for i:=1 to 136 do b[i]:=random(65535)+random;
      for i:=1 to 135 do for j:=i+1 to 136 do if b[i]<b[j] then begin
        swap(a[i],a[j]); bb:=b[i]; b[i]:=b[j]; b[j]:=bb; end;
    end;
  end;
  procedure initj;
    var
      i,j:byte;
  begin
    printinit;
    rp(a); anum:=1;
    fillchar(sh,sizeof(sh),0);
    for i:=1 to 4 do begin
      for j:=1 to 13 do begin
        sh[i,j]:=a[anum];
        anum:=anum+1;
      end;
      dihu[i]:=true;
    end;tianhu:=true;psx:=true;
    ahuir:=136-((random(6)+1)+(random(6)+1))*2;
    alast:=ahuir-1;
    gangn:=136;pgl:=false;
    huir[1].lb:=a[ahuir].lb;huir[1].sz:=a[ahuir].sz;
    for i:=2 to numhuir do begin
      huir[i].lb:=huir[1].lb;
      huir[i].sz:=huir[i-1].sz+1;
      if huir[1].lb= z then if huir[i].sz=5  then huir[i].sz:=1;
      if huir[1].lb= z then if huir[i].sz=8  then huir[i].sz:=5;
      if huir[1].lb<>z then if huir[i].sz=10 then huir[i].sz:=1;
    end;
    if nogradeb then begin
      numzhuang:=numzhuang+1; textcolor(3); write(numzhuang:6,':');
      if numzhuang=100000000 then numzhuang:=1;
    end;
    fillchar(al,sizeof(al),4);
    for i:=1 to numhuir do
      al[huir[i].lb,huir[i].sz]:=0;
    bmp2(tupian+'\'+han+'\sy.bmp',220,24,15,4);
    bmp2(tupian+'\'+han+'\h.dib',268,24,15,4);
    bmp2(tupian+'\'+han+'\d.dib',320,24,15,4);
    bmp2(tupian+'\'+han+'\q.bmp',345,24,15,4);
    bmp2(tupian+'\'+han+'\j.bmp',375,24,15,4);
    bmp2(tupian+'\'+han+'\a.dib',390,24,15,4);
    bmp2(tupian+'\'+han+'\h.bmp',500,24,15,4);
    bmp2(tupian+'\'+han+'\e.bmp',515,24,15,4);
    bmp2(tupian+'\'+han+'\'+dnxb[(nzhuang-1) mod 4]+'.bmp',360,24,15,4);
    bmp2(tupian+'\'+shu+'\'+chr((nzhuang-1) div 4+49)+'.bmp',335,24,15,4);
    if qihu=1 then bmp2(tupian+'\'+han+'\y.bmp',60,24,15,4)
              else bmp2(tupian+'\'+han+'\w.dib',60,24,15,4);
    if qihu=2 then begin
      bmp2(tupian+'\'+han+'\o.bmp',75,24,15,4);
      bmp2(tupian+'\'+han+'\u.bmp',90,24,15,4);
    end else begin
      bmp2(tupian+'\'+han+'\h.bmp',75,24,15,4);
      bmp2(tupian+'\'+han+'\e.bmp',90,24,15,4);
      bmp2(tupian+'\'+han+'\i.bmp',105,24,15,4);
    end;
    bmp2(tupian+'\'+han+'\j.bmp', 300,272,15,4);
    bmp2(tupian+'\'+han+'\dc.bmp',316,272,15,4);
    for i:=1 to numhuir do printp(huir[i],511+24*i,18,4,true);
    printsx(15);
{
    for i:=1 to 3 do sh[4,i].sz:=i+2;
    for i:=4 to 6 do sh[4,i].sz:=6;
    for i:=1 to 6 do sh[4,i].lb:=w;
    for i:=7 to 13 do sh[4,i].lb:=t;
{
    for i:=1 to 4 do sh[4,i]:=huir[1];
    for i:=1 to 4 do sh[4,i]:=huir[2];
    for i:=1 to 4 do with sh[4,7+i] do begin lb:=w; sz:=3; end;

    for i:=1 to 12 do sh[1,i].lb:=t;
    sh[1,13].lb:=w;
    sh[1,13].sz:=3;

    for i:=1 to 4 do sh[2,i]:=huir[2];
    for i:=5 to 8 do sh[2,i]:=ww;

    for i:=1 to 9 do with sh[4,i] do begin lb:=huir[1].lb;sz:=i; end;
    for i:=10 to 12 do sh[4,i]:=ww;

    for i:=1 to 9 do with sh[3,i] do begin lb:=huir[1].lb;sz:=i; end;
    for i:=10 to 12 do sh[3,i]:=huir[2];

    sh[4,1]:=huir[1];
    for i:=2 to 13 do sh[4,i]:=ww;
    for i:=10 to 13 do sh[4,i].sz:=4;
    sh[4,2].sz:=1;
    for i:=13*4+1 to 13*4+4 do a[i]:=ww;
    a[136]:=ww;
{}
    for i:=1 to 4 do begin num[i]:=14; thr[i]:=0; px(sh[i],num[i]); end;
    for j:=1 to 4 do if j<>dong+nzhuang-1 then for i:=1 to 13 do
     printb(sh[j,i],j,ord(i<num[j])*i+ord(i>num[j])*(2.4+num[j]+0.75*(i-num[j])+0.4*((i-num[j]-1)div 3)),j=4);
    printz;
    printform(false,false,false,false);printscore(15);
    gkhl:=false;kggz:=false;zjkg:=false;xiangg:=false;checkth:=false;
 end;
  procedure run;
    var  i:byte;
  begin
    lun:=(nzhuang) mod 4;
    while sx>0 do begin
      if not pgl then begin
        gotpic(sh[(zhua-1)mod 4+1,num[(zhua-1)mod 4+1]],(zhua-1)mod 4+1);
        if choose((zhua-1)mod 4+1,1) then exit;
        dec(al[throwout.lb,throwout.sz]);
      end;pgl:=false;
      if runexit or gkhl then exit;
      for i:=1 to 4 do if i<>(zhua-1)mod 4+1 then
        if ablepg(i)<>0 then if (i=4) and not debugger then nptpg(ablepg(i)) else compg(sh[i],ablepg(i),i);
      if runexit then exit;
      if not pgl then lun:=(lun+1) mod 4;
      if gkhl then exit;
    end;
    huangp;if runexit then exit;
  end;
  procedure huangp;
    var
      i,j:byte;
      event:tevent;
      debugfile:text;
  begin
    if not nogradeb then begin
      setfillstyle(1,2);bar(284,252,384,288);
    end;
    for j:=1 to 4 do for i:=1 to 14 do if i<>num[j] then
     printb(sh[j,i],j,ord(i<num[j])*i+ord(i>num[j])*(2.4+num[j]+0.75*(i-num[j])+0.4*((i-num[j]-1)div 3)),true);
    bmp2(tupian+'\'+han+'\u.dib',316,272,15,4);
    bmp2(tupian+'\'+han+'\p.dib',332,272,15,4);
    mouseinput(event,6);if runexit then exit;
    if kggz and not zjkg then inc(nzhuang);
    if debugger then begin
      assign(debugfile,'Debug.LOG');
      if exist('debug.log') then append(debugfile) else begin
        rewrite(debugfile);writeln(debugfile,'家'#9'完成'#9'大小'#9'名称');
      end;writeln(debugfile,0,#9,0.:1:5,#9,0,#9,'-');
      close(debugfile);
    end;
    if nogradeb then begin
      textcolor(lightblue); writeln;
      write('       -   0.00000       0          hp');
      for i:=1 to 4 do write(score[i]:5);
      textcolor(15);writeln;
    end;
  end;
  procedure win(n:byte);
    var
      i,j:byte;
      event:tevent;
      hupnumstr:string;
      b:tiao;m,h,z,l,e:boolean;
      debugfile:text;
  begin
    if soundp then begin
      sound(1153);delay(100); sound(1044);delay(50);
      nosound;    delay(40);  sound(1044);delay(50); nosound;
    end;
    gkhl:=true;
    if not nogradeb then begin
      setfillstyle(1,2);bar(97,125,576,422);
    end;
    j:=n;for i:=1 to 14 do
     printb(sh[j,i],j,
      ord(i<num[j])*i+ord(i=num[j])*(num[j]+1)+ord(i>num[j])*(2.4+num[j]+0.75*(i-num[j])+0.4*((i-num[j]-1) div 3)),true);
    bmp2(tupian+'\'+han+'\'+dnxb[(4+n-dong) mod 4]+'.bmp',
         120,187,15,4);
    for i:=1 to 14 do
     printp(sh[n,i],116+round(24*(ord(i<=num[n])*i+ord(i=num[n])
             +ord(i>num[n])*(2.4+num[n]+0.75*(i-num[n])+0.4*((i-num[n]-1)div 3))))
            ,180,4,true);
    if hupstr='' then hupstr:='ou';
    for i:=1 to length(hupstr) do bmp2(tupian+'\'+han+'\'+hupstr[i]+'.bmp',120+i*15,230,15,4);
    hupnumstr:='('+inttostr(hupnum)+')';
    for i:=1 to length(hupnumstr) do bmp2(tupian+'\'+shu+'\'+hupnumstr[i]+'.bmp',120+length(hupstr)*15+i*8+7,230,15,4);
    scorep(n,hupnum,zuozhuang);
    ba2tiao(sh[n],b,num[n]);
    if checkth then thsm(b,m,h,z,l,e) else xz(b,m,h,z,l,e);
    checkth:=false;
     printhp(n);
    mouseinput(event,n+1);if runexit then exit;
    if debugger then begin
{      scrprint.Showinf;
      scrprint.ScreenPrint(scrprint.AutoName+'.bmp');scrprint.DisShowInf;}
      assign(debugfile,'Debug.LOG');
      if exist('debug.log') then append(debugfile) else begin
        rewrite(debugfile);writeln(debugfile,'家'#9'完成'#9'大小'#9'名称');
      end;writeln(debugfile,n,#9,sx/alast:1:5,#9,hupnum,#9,hupstr);
      close(debugfile);
    end;
    if n mod 4<>(dong+nzhuang-1) mod 4 then inc(nzhuang);
    if nogradeb then begin
      writeln; textcolor(7); write('':7);
      textcolor(lightgreen+blink*ord(hupnum>=4)+ord(hupnum>=7));
      write(n,'':3,sx/alast:1:5,hupnum:8,hupstr:12);
      for i:=1 to 4 do write(score[i]:5);
      textcolor(15);writeln;
    end;
  end;
  procedure checkexit;
    var event:tevent;
  begin
    if not nogradeb then begin
      setfillstyle(1,2);bar(0,16,getmaxx,getmaxy);
    end;
    printz;printscore(15);
    bmp2(tupian+'\'+han+'\c.bmp',270,272,15,4);
    bmp2(tupian+'\'+han+'\t.dib',340,272,15,4);
    repeat
      mouseinput(event,0);
{     setcolor(0);outtextxy(0,0,#219#219#219#219#219);{}
{     setcolor(4);outtextxy(0,0,inttostr(event.where.x)+','+inttostr(event.where.y));{}
      if event.where.y in [34..36] then begin
        if event.where.x in [34..39] then runexit:=true
        else if event.where.x in [42..46] then exit;
      end;
    until runexit;
  end;
end.
