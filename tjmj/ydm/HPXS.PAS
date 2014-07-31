unit hpxs;
interface
  uses
    constant, types, variable, CRT, print, ba2t, bmp, bmp2b, bmp16b;
  type
    numt=array [z..t] of byte;
  var
    zhuowur:boolean;
    loong:lei;
    huirdiao:byte;
    meihuir:boolean;
    jiang:zhang;
    numwbt,baknum:numt;
    hulist:ba;hunum:byte;
    hutiao:tiao;
    huirl:ba;
    lstzw,huirnum:byte;
  procedure printhp(n:byte);
implementation
   procedure huirlist(n:byte);
    var i:byte;
  begin
    huirnum:=0;
    for i:=1 to 14 do
     if samehuir(sh[n,i]) then begin
       huirnum:=huirnum+1; huirl[huirnum]:=sh[n,i];
     end;
  end;
  procedure hphlz(n:byte);
    var i:byte;
  begin
    lstzw:=0;
    if huirdiao<>1 then hunum:=hunum-2;
    if huirdiao=2 then begin
      hulist[hunum-2]:=bm;
      if not zhuowur then begin
        hulist[hunum]:=last;
        hulist[hunum-1]:=bm;
      end else begin
        hulist[hunum]:=bm;
        hulist[hunum-1]:=last;
        if not same(last,ww) then lstzw:=hunum-1;
      end;
      dec(hutiao[last.lb,last.sz]);
      dec(hutiao[z,8],2);
      dec(hunum,3);
    end else if huirdiao=1 then begin
      hulist[hunum]:=last;
      hulist[hunum-1]:=bm;
      dec(hutiao[last.lb,last.sz]);
      dec(hutiao[z,8],1);
      dec(hunum,2);
    end;
    if zhuowur and (huirdiao<>2) then begin
      {6w}
      if hutiao[w,6]<>0 then begin
        dec(hutiao[w,6],1); hulist[hunum].lb:=w; hulist[hunum].sz:=6;
      end else begin
        dec(hutiao[z,8],1); hulist[hunum]:=bm;
      end;
      hunum:=hunum-1;
      {5w}
      if same(last,ww) then begin
        dec(hutiao[w,5],1); hulist[hunum].lb:=w; hulist[hunum].sz:=5;
      end else begin
        dec(hutiao[z,8],1); hulist[hunum]:=bm; lstzw:=hunum;
      end;
      hunum:=hunum-1;
      {4w}
      if hutiao[w,4]<>0 then begin
        dec(hutiao[w,4],1); hulist[hunum].lb:=w; hulist[hunum].sz:=4;
      end else begin
        dec(hutiao[z,8],1); hulist[hunum]:=bm;
      end;
      hunum:=hunum-1;
    end;
    if loong<>z then begin
      for i:=9 downto 1 do if not ((zhuowur) and (loong=w) and (i in [4..6]) and (huirdiao<>2)) then begin
        {i,loong}
        if hutiao[loong,i]<>0 then begin
          dec(hutiao[loong,i],1); hulist[hunum].lb:=loong; hulist[hunum].sz:=i;
        end else begin
          dec(hutiao[z,8],1); hulist[hunum]:=bm;
        end;
        hunum:=hunum-1;
      end;
    end;
    if huirdiao<>1 then with jiang do
      {jiang}
     for i:=1 to 2 do begin
       if hutiao[lb,sz]<>0 then begin
          dec(hutiao[lb,sz],1); hulist[num[n]-i+1]:=jiang;
       end else begin
         dec(hutiao[z,8],1); hulist[num[n]-i+1]:=bm;
       end;
     end;
  end;
  procedure printlist(n:byte);
    var
      i:byte;huiro:byte;
  begin
    huiro:=0;
    for i:=1 to num[n] do
     if same(hulist[i],bm) then
      if (i=lstzw) and not same(last,bm) then begin
       printp(last,116+i*width+(i-1) div 3*12,280,4,true);
       bmp16(tupian+'\0.bmp',116+i*width+(i-1) div 3*12,280,0,4);
      end else begin
       inc(huiro);
       printp(huirl[huiro],116+i*width+(i-1) div 3*12,280,4,true);
       bmp16(tupian+'\0.bmp',116+i*width+(i-1) div 3*12,280,0,4);
     end else
     printp(hulist[i],116+i*width+(i-1) div 3*12,280,4,true);
    for i:=num[n]+1 to 14 do
     printp(sh[n,i],116+num[n]*width+(num[n]+1) div 3*12+18*(i-num[n]+1)+10*((i-num[n]-1)div 3),280,4,true);
  end;
  procedure filz;
    var i,j:byte;
  begin
    for i:=1 to 7 do if hutiao[z,i]<>0 then begin
      for j:=1 to 3 do begin
        if hutiao[z,i]<>0 then begin
           dec(hutiao[z,i],1); hulist[hunum].lb:=z; hulist[hunum].sz:=i;
        end else begin
          dec(hutiao[z,8],1); hulist[hunum]:=bm;
        end;
        hunum:=hunum-1;
      end;
      i:=i-1;
    end;
  end;
  function try(l:lei):boolean;
    var
      i,j:byte;flag:boolean;
      numbak:numt;hutbak:tiao;
  begin
    numbak:=numwbt;hutbak:=hutiao;
    for i:=9 downto 1 do if hutiao[l,i]<>0 then begin
      {Type 1 - AAA, AA?, A??}
        if hutiao[l,i]+numwbt[l]>=3 then begin
          for j:=1 to 3 do begin
            if hutiao[l,i]<>0 then begin
               dec(hutiao[l,i],1); hulist[hunum].lb:=l; hulist[hunum].sz:=i;
            end else begin
              dec(numwbt[l],1); hulist[hunum]:=bm;
            end;
            hunum:=hunum-1;
          end;
          if try(l) then begin try:=true; exit end else begin
            hunum:=hunum+3;hutiao:=hutbak;numwbt:=numbak;
          end;
        end;
      {Type 1 End}
      {Type 2 - ABC, AB?, A?B, ?AB}
        flag:=false;
        if (i<8) and (ord(hutiao[l,i+1]<>0)+ord(hutiao[l,i+2]<>0)+ord(numwbt[l]<>0)>=2) then flag:=true;
        if (i=8) and (ord(hutiao[l,9]<>0)+ord(numwbt[l]<>0)>=2) then flag:=true;
        if flag then begin
          for j:=i+2-ord(i=8) downto i-ord(i=8) do begin
            if hutiao[l,j]<>0 then begin
               dec(hutiao[l,j],1); hulist[hunum].lb:=l; hulist[hunum].sz:=j;
            end else begin
              dec(numwbt[l]); hulist[hunum]:=bm;
            end;
            hunum:=hunum-1;
          end;
          if try(l) then begin try:=true; exit end else begin
            hunum:=hunum+3;hutiao:=hutbak;numwbt:=numbak;
          end;
        end;
      {Type 2 End}
    end;
    for i:=1 to 9 do if hutiao[l,i]<>0 then break;
    try:=hutiao[l,i]=0
  end;
  procedure printhp(n:byte);
    var
      l:lei;i:byte;
  begin
    if huirdiao=1 then jiang:=last;
    fillchar(hulist,sizeof(hulist),0);
    hunum:=num[n];huirlist(n);
    ba2tiao(sh[n],hutiao,hunum);
    hphlz(n);
    filz;
    for l:=w to t do try(l);
    for i:=hunum downto 1 do hulist[i]:=bm;
    printlist(n);
  end;
end.