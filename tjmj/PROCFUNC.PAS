unit procfunc;
interface
  uses
    types,constant,variable,bmp,
    graph,dos,gramouse,print,pdhp,drivers,crt,comq,prcot;
  procedure cmd(command:string);
  procedure initj;
  procedure init;
  procedure minit;
  procedure run;
  procedure win(n:byte);
  procedure huangp;
  procedure checkexit;
implementation
  procedure cmd(command:string);
  begin
    Command := '/C ' + Command;
    SwapVectors;
    Exec(GetEnv('COMSPEC'), Command);
    SwapVectors;
  end;
  procedure printinit;
  begin
    setfillstyle(1,2);
    bar(0,16,getmaxx,getmaxy);
    bmp16(tupian+'\'+caidan+'.bmp',0,0,16,4);
  end;
  procedure minit;
    var
      i:byte;
  begin
    for i:=1 to 4 do score[i]:=250;
    d:=random(4)+1;
    lun:=1;dong:=random(4)+1;nzhuang:=1;
    runexit:=false;
  end;
  procedure init;
    var
      i,j,n:byte;
      l:lei;
  begin
    n:=0;
    for l:=z to t do
     for i:=1 to 9-2*ord(l=z) do
      for j:=1 to 4 do begin
        n:=n+1;a[n].lb:=l;a[n].sz:=i;
      end;
    inigraph;
    printinit;
    graphmouseinit;
  end;

  procedure gotpic(var zh:zhang;n:byte);
  begin
    printsx(2);
    last:=a[anum];anum:=anum+1;
    zh:=last;
    if (last.lb=huir.lb) and (last.sz in [huir.sz,huir2.sz]) then begin
      last.lb:=z;last.sz:=8;
    end;
    printb(sh[n,num[n]],n,num[n]+1,n=4);
    if sx>20 then printsx(15) else printsx(12);
  end;
  procedure angang(n:byte;gz:zhang);
    var
      i,j:byte;
  begin
        {An Gang}
      sound(1746);delay(200);nosound;
      j:=0;
      for i:=1 to num[n]-4 do begin
        if same(sh[n,i],gz) then begin
          swap(sh[n,i],sh[n,num[n]-j]);inc(j); dec(i);
        end;
      end;
      inc(sh[n,num[n]-2].lb,8);
      inc(sh[n,num[n]-1].lb,4);
      inc(sh[n, num[n] ].lb,8);
      dec(num[n],3);
      sh[n,num[n]].lb:=lei(0);
      sh[n,num[n]].sz:=0;
      px(sh[n],num[n]-1);
      gotlastpic(n);
      clearb(n);
      if n=1 then bar(0,getmaxy-30,64,getmaxy);
      for i:=1 to 14 do
       printb(sh[n,i],n,ord(i<=num[n])*i+ord(i=num[n])+ord(i>num[n])*(2.4+num[n]+0.75*(i-num[n])+
            0.4*((i-num[n]-1)div 3)),(n=4) or (i>num[n]));
      printscore(2);
      inc(score[n],8);for i:=1 to 4 do dec(score[i],2);
      printz;printscore(15);
        {An Gang}
      pgl:=true;
  end;
  procedure minggang(n:byte;gz:zhang);
    var
      i,j:byte;
  begin
      sound(1746);delay(200);nosound;checkkeyboard;
        {Ming Gang}
      for i:=1 to num[n]-1 do begin
        if same(sh[n,i],gz) then begin
          swap(sh[n,i],sh[n,num[n]]);break
        end;
      end;
      for i:=num[n]+1 to 14 do if same(sh[n,i],gz) then break;
      inc(sh[n,i+1].lb,4);
      sh[n,num[n]].lb:=lei(0);
      sh[n,num[n]].sz:=0;
      px(sh[n],num[n]-1);
      gotlastpic(n);
      for i:=1 to 16 do
       printb(dl,n,i,true);
      if n=1 then bar(0,getmaxy-30,64,getmaxy);
      for i:=1 to 14 do
       printb(sh[n,i],n,ord(i<=num[n])*i+ord(i=num[n])+ord(i>num[n])*(2.4+num[n]+0.75*(i-num[n])+
            0.4*((i-num[n]-1)div 3)),(n=4) or (i>num[n]));
      printscore(2);
      inc(score[n],4);for i:=1 to 4 do dec(score[i]);
      printz;printscore(15);
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
      i,j,u:byte;
      z:zhang;
    function userg2:boolean;
      var
        b:tiao;
        i,j,n,ic:byte;
        gz:zhang;
        flag:boolean;
    begin
      ba2tiao(a,b,14);
      n:=0;userg2:=false;
      for i:=0 to 3 do
       for j:=1 to 9 do
       if b[lei(i),j]=4 then begin
        inc(n);gz.lb:=lei(i);gz.sz:=j;
       end;
      if n<>1 then begin
        bmp16(tupian+'\'+xuanze+'.bmp',0,getmaxy-13,16,4);
        flag:=false;
        begin
          mouseinput(event);if runexit then exit;
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
          setcolor(green);bar(0,getmaxy-13,getmaxx,getmaxy);
          if not flag then exit;
        end;
      end;
      al[gz.lb,gz.sz]:=0;
      ba2tiao(a,b,num[4]);
      if b[gz.lb,gz.sz]=4 then begin
        AnGang(4,gz);
        userg2:=true;
      end else begin
        MingGang(4,gz);
        userg2:=true;
      end;
    end;
  begin
1:  flag:=false;gang:=false;hu:=false;
    if runexit then exit;
    if chty<>3 then begin
      ba2tiao(a,b,14);
      for i:=0 to 3 do
       for j:=1 to 9-2*ord(i=0) do
        if b[lei(i),j]=4 then gang:=true;
      ba2tiao(a,b,num[4]);
      if hupai(b) then hu:=(xz(b,c,d,e,f,g)*(1+ord(chty=2))>=2) else hu:=false;
    end;
    printform(false,gang,hu,false);
    repeat
      mouseinput(event);if runexit then exit;
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
            hupnum:=xz(b,c,d,e,f,g);hupstr:=mingming(c,d,e,f,g);
            if chty=2 then begin hupnum:=2*hupnum; hupstr:='gk'+hupstr end;
            inpchose:=15; exit;
          end;
          18..20:if gang then begin
            u:=0;
            if userg2 then begin
              chty:=2;goto 1;
            end;
          end;
        end;
      end;
    until flag;
    printform(false,false,false,false);
  end;
 procedure CPpeng(n:byte);
   var
     i,j:byte;
 begin
   sound(4176);delay(200);nosound;checkkeyboard;
   dec(thr[(zhua-1)mod 4+1]);
   printthr(cl,(zhua-1)mod 4+1);
   j:=1;sh[n,num[n]]:=throwout;
   for i:=1 to num[n] do
     if same(sh[n,i],throwout) then begin
       swap(sh[n,i],sh[n,num[n]-j]);inc(j);dec(i);
       if j>2 then break;
     end;
   num[n]:=num[n]-3;
   px(sh[n],num[n]);
   printb(dl,n,1,true);
   printscore(15);printz;
   for i:=2 to 16 do
    printb(dl,n,i,true);
   if n=1 then bar(0,getmaxy-30,64,getmaxy);
   for i:=1 to 14 do
    printb(sh[n,i],n,ord(i<=num[n])*i+ord(i=num[n])+ord(i>num[n])*(2.4+num[n]+0.75*(i-num[n])+
         0.4*((i-num[n]-1)div 3)),(n=4) or (i>num[n]));
   choose(n,3);
   lun:=(4+n-dong) mod 4+1;dec(al[throwout.lb,throwout.sz],2);
 end;
    procedure CPgang(n:byte){Ming};
      var
        i,j:byte;
    begin
      sound(1746);delay(200);nosound;checkkeyboard;
       dec(thr[(zhua-1)mod 4+1]);
       printthr(cl,(zhua-1)mod 4+1);
      sh[n,num[n]]:=throwout;j:=0;
      for i:=1 to num[n]-4 do begin
        if same(sh[n,i],throwout) then begin
          swap(sh[n,i],sh[n,num[n]-j]);inc(j);dec(i);
        end;
      end;
      inc(sh[n,num[n]-1].lb,4);dec(num[n],3);
      px(sh[n],num[n]-1);
      gotlastpic(n);
      printb(dl,n,1,true);
      for i:=2 to 16 do
       printb(dl,n,i,true);
      if n=1 then bar(0,getmaxy-30,64,getmaxy);
      for i:=1 to 14 do
       printb(sh[n,i],n,ord(i<=num[n])*i+ord(i=num[n])+ord(i>num[n])*(2.4+num[n]+0.75*(i-num[n])+
            0.4*((i-num[n]-1)div 3)),(n=4) or (i>num[n]));
      printscore(2);
      inc(score[n],4);for i:=1 to 4 do dec(score[i]);
      printz;printscore(15);
      choose(n,2);
      lun:=(4+n-dong) mod 4+1;al[throwout.lb,throwout.sz]:=0;
      pgl:=true;
    end;
  function compg(var a:ba;numb,n:byte):byte;
    label 1;
    var
      ba,b:numlt;
      i:byte;
      iu:iult; all:tl; lll:lei;
      n1,n2:real;
  begin
    if throwout.lb=z then begin
      if boolean(numb and 1) then cpgang(n) else if boolean(numb and 2) then cppeng(n);
      exit;
    end;
    fillchar(b,sizeof(b),0);a[num[n]]:=throwout;
    for i:=1 to num[n] do if lei(byte(a[i].lb) mod 4)=throwout.lb then inc(b[a[i].sz]);
    n1:=inusel(b,iu,all,lll,false,n);ba:=b;
    if boolean(numb and 1) then begin {Gang}
      b:=ba; b[throwout.sz]:=0;
      n2:=inusel(b,iu,all,lll,false,n)+549;
      if n2>n1 then CPGang(n) else goto 1;
    end else if boolean(numb and 2) then begin
1:    b:=ba; dec(b[throwout.sz],3);
      n2:=inusel(b,iu,all,lll,false,n)+549+(840-549)/4.5*ord(al[throwout.lb,throwout.sz]=3);
      if n2>n1 then begin CPPeng(n);
      {Peng}pgl:=true; end;
    end;
    dec(b[throwout.sz],3);
    a[num[n]]:=cl;
  end;
  function comgang(n:byte):boolean;
    var
      a:ba;c:tiao;b:numlt;
      i,j,k:byte;
      n1,n2:real;
      iu:iult; all:tl; lll:lei;
      gz:zhang;
  begin
    comgang:=false;
    a:=sh[n];
    ba2tiao(a,c,14);
    for j:=1 to 7 do
     if c[z,j]=4 then begin
       gz.lb:=z;gz.sz:=j;
       a:=sh[n];fillchar(b,sizeof(b),0);
       for k:=1 to num[n] do if lei(byte(a[k].lb) mod 4)=gz.lb then inc(b[a[k].sz]);
       if b[j]<>4 then minggang(n,gz) else angang(n,gz);comgang:=true;
    end;
    for i:=1 to 3 do
     for j:=1 to 9 do
     if c[lei(i),j]=4 then begin
       gz.lb:=lei(i);gz.sz:=j;
       a:=sh[n];fillchar(b,sizeof(b),0);a[num[n]]:=gz;
       for k:=1 to num[n] do if lei(byte(a[k].lb) mod 4)=gz.lb then inc(b[a[k].sz]);
       if b[j]<>4 then begin{MingGang}
         n1:=inusel(b,iu,all,lll,false,n);
         b[gz.sz]:=0;
         n2:=inusel(b,iu,all,lll,false,n)+300;
         if n2>n1 then begin MingGang(n,gz); comgang:=true; end;
       end else begin{AnGang}
         n1:=inusel(b,iu,all,lll,false,n);
         b[gz.sz]:=0;
         n2:=inusel(b,iu,all,lll,false,n)+900;
         if n2>n1 then begin AnGang(n,gz); comgang:=true; end;
       end;
    end;
  end;
  function choose(n,chty:byte):boolean;
    var
      t,i,j,u:byte;
      l:zhang;
      flag:boolean;
  begin
    choose:=false;
    if n=4 then
      repeat
        t:=inpchose(sh[n],chty);
        if runexit then exit;
        if t=15 then break;
      until not (same(sh[4,t],huir) or same(sh[4,t],huir2))
    else begin
      if chty=3 then t:=comchose(n,3) else t:=comchose(n,1+ord(comgang(n)));
    end;
    if t=15 then begin
      win(n);choose:=true;gkhl:=true;exit;
    end;
    l:=sh[n,t];throwout:=l;
    printthr(sh[n,t],n);inc(thr[n]);
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
    j:=0;
    ba2tiao(sh[n],b,num[n]-1);
    for i:=1 to num[n]-1 do
     if same(sh[n,i],throwout)
       then inc(j);
    ablepg:=ord((j>=2) and (b[z,8]+j<>num[n]-1))*2+ord(j=3);
    if sx=0 then ablepg:=0;
  end;
  procedure nptpg(numb:byte);
    var
      event:tevent;eve:char;
      flag:boolean;
  begin
    printform(numb and 2<>0,numb and 1<>0,false,true);
    printp(throwout,(getmaxx-15*width) div 2+((num[4]+2)-1)*width,getmaxy-py-height,4,true);
    repeat
      mouseinput(event);if runexit then exit;
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
    printp(cl,(getmaxx-15*width) div 2+((num[4]+2)-1)*width,getmaxy-py-height,4,true);
  end;
  procedure rp(var a:tao);
    var
      r:byte;
      i,j,k:byte; bb:real; l:lei;
      b:array [1..136] of real;
  begin;
    for r:=1 to 5 do begin
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
    end;
    alast:=135-((random(6)+1)+(random(6)+1))*2;
    gangn:=136;pgl:=false;
    huir.lb:=a[alast+1].lb;huir.sz:=a[alast+1].sz;
    huir2.lb:=huir.lb;huir2.sz:=huir.sz mod (9)+1;
    if huir.lb=z then begin
      case huir.sz of
        1..4:huir2.sz:=huir.sz mod 4+1;
        5..7:huir2.sz:=(huir.sz-4) mod 3+5;
      end;
    end;
    fillchar(al,sizeof(al),4);
    al[huir.lb,huir.sz]:=0;al[huir2.lb,huir2.sz]:=0;
    bmp2(tupian+'\'+han+'\sy z.bmp',220,24,15,4);
    bmp2(tupian+'\'+han+'\dqz.bmp',320,24,15,4);
    bmp2(tupian+'\'+han+'\h.bmp',500,24,15,4);
    bmp2(tupian+'\'+han+'\e.bmp',515,24,15,4);
    bmp2(tupian+'\'+han+'\'+dnxb[(nzhuang-1) mod 4]+'.bmp',358,24,15,4);
    bmp2(tupian+'\'+shu+'\'+chr((nzhuang-1) div 4+49)+'.bmp',335,24,15,4);
    printp(huir,535,18,4,true);printp(huir2,559,18,4,true);
    printsx(15);
    for i:=1 to 4 do begin num[i]:=14; thr[i]:=0; px(sh[i],num[i]); end;
    for j:=1 to 4 do for i:=1 to 13 do
     printb(sh[j,i],j,ord(i<num[j])*i+ord(i>num[j])*(2.4+num[j]+0.75*(i-num[j])+0.4*((i-num[j]-1)div 3)),j=4);
    printz;
    printform(false,false,false,false);printscore(15);
    gkhl:=false;
    for i:=1 to 4 do begin ltype[i]:=z; ltype_[i]:=0; end;
  end;
  procedure run;
    var
      i:byte;
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
        if ablepg(i)<>0 then if i=4 then nptpg(ablepg(i)) else compg(sh[i],ablepg(i),i);
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
  begin
    bar(95,120,580,424);
    for j:=1 to 4 do for i:=1 to 14 do if i<>num[j] then
     printb(sh[j,i],j,ord(i<num[j])*i+ord(i>num[j])*(2.4+num[j]+0.75*(i-num[j])+0.4*((i-num[j]-1)div 3)),true);
    bmp2(tupian+'\'+han+'\hp.bmp',270,230,15,4);
    mouseinput(event);if runexit then exit;
  end;
  procedure win(n:byte);
    var
      i,j:byte;
      event:tevent;
      hupnumstr:string;
  begin
    gkhl:=true;
    if n mod 4<>(dong+nzhuang-1) mod 4 then inc(nzhuang);
    bar(95,120,576,422);
    j:=n;for i:=1 to 14 do
     printb(sh[j,i],j,ord(i<num[j])*i+ord(i=num[j])*(num[j]+1)+ord(i>num[j])*(2.4+num[j]+0.75*(i-num[j])+0.4*((i-num[j]-1)div
3)),true);
    bmp2(tupian+'\'+han+'\'+dnxb[(4+n-dong) mod 4]+'.bmp',
         120,187,15,4);
    for i:=1 to 14 do
     printp(sh[n,i],116+round(24*(ord(i<=num[n])*i+ord(i=num[n])
             +ord(i>num[n])*(2.4+num[n]+0.75*(i-num[n])+0.4*((i-num[n]-1)div 3))))
            ,180,4,true);
    for i:=1 to length(hupstr) do bmp2(tupian+'\'+han+'\'+hupstr[i]+'.bmp',120+i*15,230,15,4);
    hupnumstr:='('+inttostr(hupnum)+')';
    for i:=1 to length(hupnumstr) do bmp2(tupian+'\'+shu+'\'+hupnumstr[i]+'.bmp',120+length(hupstr)*15+i*8+7,230,15,4);
    printscore(2);
    inc(score[n],hupnum*4);for i:=1 to 4 do dec(score[i],hupnum);
    printscore(15);
    mouseinput(event);if runexit then exit;
  end;
  procedure checkexit;
    var event:tevent;
  begin
    bar(0,16,getmaxx,getmaxy);
    printz;printscore(15);
    bmp16(tupian+'\'+cktc+'.bmp',230,230,13,4);
    repeat
      mouseinput(event);
      if event.where.y in [29..32] then begin
        if event.where.x in [29..40] then runexit:=true
        else if event.where.x in [41..52] then exit;
      end;

      outtext(IntToStr(event.where.x)+'-'+inttostr(event.where.y));
    until runexit;
  end;
end.
