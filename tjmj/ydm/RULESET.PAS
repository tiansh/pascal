unit ruleset;
interface
  uses bmp, bmp2b, bmp16b,constant,variable,graph,prcot,drivers,print,gramouse,filexist;
  procedure rulecf;
  procedure printinit;
  procedure ruleinit;
  procedure saveset;
implementation
  procedure printinit;
  begin
    if nogradeb then exit;
    setfillstyle(1,2);setcolor(2);
    bar(0,16,getmaxx,getmaxy);
    bmp16(tupian+'\'+caidan+'1.bmp',0,0,16,4);
    bmp16(tupian+'\'+caidan+'2.bmp',getmaxx-16,0,16,4);
    setfillstyle(1,7);bar(194,0,getmaxx-17,15);
  end;
   procedure printtabletitle;
     var x,y:word;
   begin
{    bmp2(tupian+'\'+han+'\o.bmp',180-120,140,15,4);{}
{    bmp2(tupian+'\'+han+'\u.bmp',195-120,140,15,4);{}
    bmp2(tupian+'\'+han+'\g.dib',10,1,0,4);
    bmp2(tupian+'\'+han+'\g.dib',275,60 ,15,4);{guize}
    bmp2(tupian+'\'+han+'\h.bmp',180-120,100,15,4);   bmp2(tupian+'\'+han+'\e.bmp',195-120,100,15,4);
    bmp2(tupian+'\'+han+'\p.dib',210-120,100,15,4);   bmp2(tupian+'\'+han+'\h.dib',225-120,100,15,4);
    bmp2(tupian+'\'+han+'\s.dib',240-120,100,15,4);   bmp2(tupian+'\'+han+'\z.dib',180-120,180,15,4);
    bmp2(tupian+'\'+han+'\a.dib',195-120,180,15,4);   bmp2(tupian+'\'+han+'\h.bmp',180+136,100,15,4);
    bmp2(tupian+'\'+han+'\e.bmp',195+136,100,15,4);   bmp2(tupian+'\'+han+'\`.bmp',180+136,140,15,4);
    bmp2(tupian+'\'+han+'\~.bmp',195+136,140,15,4);   bmp2(tupian+'\'+shu+'\(.bmp',210+136,140,15,4);
    bmp2(tupian+'\'+han+'\w.bmp',217+136,140,15,4);   bmp2(tupian+'\'+shu+'\).bmp',232+136,140,15,4);
    bmp2(tupian+'\'+han+'\l.bmp',239+136,140,15,4);   bmp2(tupian+'\'+han+'\g.bmp',210+136,100,15,4);
    bmp2(tupian+'\'+han+'\t.bmp',180+136,180,15,4);   bmp2(tupian+'\'+han+'\u.bmp',195+136,180,15,4);
    bmp2(tupian+'\'+han+'\syb.bmp',210+136,180,15,4); bmp2(tupian+'\'+han+'\t.bmp',180-120,220,15,4);
    bmp2(tupian+'\'+han+'\u.bmp',195-120,220,15,4);   bmp2(tupian+'\'+han+'\0.bmp',180+136,220,15,4);
    bmp2(tupian+'\'+han+'\u.bmp',195+136,220,15,4);   bmp2(tupian+'\'+han+'\sz.bmp',275,260,15,4);{shezhi}
    bmp2(tupian+'\'+han+'\dnsd.bmp',180-120,300,15,4);bmp2(tupian+'\'+han+'\xg.bmp',180+136,300,8+7*ord(not debugger),4);
    bmp2(tupian+'\'+han+'\cz.bmp',275-32,356,15,4);   bmp2(tupian+'\'+han+'\qd.bmp',275+32,356,15,4);
   end;
   procedure printhuirnum;
   begin
    bmp2(tupian+'\'+shu+'\3.bmp',300-120,100,8+7*ord(1=numhuir),4);
    bmp2(tupian+'\'+shu+'\7.bmp',330-120,100,8+7*ord(2=numhuir),4);
    bmp2(tupian+'\'+shu+'\1.bmp',360-120,100,8+7*ord(3=numhuir),4);
    bmp2(tupian+'\'+shu+'\1.bmp',368-120,100,8+7*ord(3=numhuir),4);
   end;
   procedure printxiaohu;
   begin
     bmp2(tupian+'\'+han+'\y.bmp',180-120,140,8+7*ord(qihu=1),4);
     bmp2(tupian+'\'+han+'\o.bmp',195-120,140,8+7*ord(qihu=1),4);
     bmp2(tupian+'\'+han+'\u.bmp',210-120,140,8+7*ord(qihu=1),4);

     bmp2(tupian+'\'+han+'\w.dib',248-120,140,8+7*ord(qihu=2),4);
     bmp2(tupian+'\'+han+'\o.bmp',263-120,140,8+7*ord(qihu=2),4);
     bmp2(tupian+'\'+han+'\u.bmp',278-120,140,8+7*ord(qihu=2),4);

     bmp2(tupian+'\'+han+'\w.dib',316-120,140,8+7*ord(qihu=3),4);
     bmp2(tupian+'\'+han+'\h.bmp',331-120,140,8+7*ord(qihu=3),4);
     bmp2(tupian+'\'+han+'\e.bmp',346-120,140,8+7*ord(qihu=3),4);
     bmp2(tupian+'\'+han+'\i.bmp',361-120,140,8+7*ord(qihu=3),4);
   end;
   procedure printzuozhuang;
   begin
    bmp2(tupian+'\'+han+'\y.bmp',300-120,180,8+7*ord(    zuozhuang),4);
    bmp2(tupian+'\'+han+'\w.dib',360-120,180,8+7*ord(not zuozhuang),4);
   end;
   procedure cleardelaytime;
   begin
     if nogradeb then exit;
     setfillstyle(1,2);
     bar(325-120,300,360-120,314);
   end;
   procedure printdelaytime;
     function IntToStr(I: Longint): String;
       var S: string[11];
     begin Str(I, S); IntToStr := S; end;
     var
       s:string;
       i:byte;
   begin
     s:=inttostr(delaytime);
     while length(s)<=2 do s:='0'+s;
     insert('d',s,length(s)-1);
     while length(s)<5 do s:=' '+s;
     s:='- '+s+' p';
     for i:=1 to length(s) do if s[i]<>' ' then begin
       bmp2(tupian+'\'+shu+'\'+s[i]+'.bmp',367-7*(length(s)-i)-120,300,
            8+7*ord( (s[i] in ['0'..'9','d']) or
                     ((s[i]='-') and (delaytime>10-10*ord(debugger))) or
                     ((s[i]='p') and (delaytime<400)) ) ,4);
     end;
   end;
   procedure clearhuirgang;
   begin
     if nogradeb then exit;
     setfillstyle(1,2);
     bar(325+136,100,360+136,114);
   end;
   procedure printhuirgang;
     procedure clearchrfenshu;
     begin
       if nogradeb then exit;
       setfillstyle(1,2);
       bar(225+136,100,255+136,115);
     end;
     procedure printchrfenshu;
     begin
       bmp2(tupian+'\'+han+'\-.bmp',225+136,100,15,4);
       bmp2(tupian+'\'+han+'\o.bmp',240+136,100,15,4);
     end;
     function IntToStr(I: Longint): String;
       var S: string[11];
     begin Str(I, S); IntToStr := S; end;
     var
       s:string;
       i:byte;
   begin
     s:=inttostr(huirgangnum);
     if huirgangnum=0 then clearchrfenshu else printchrfenshu;
     if s='0' then s:='w';if huirgangnum<10 then s:=s+' ';s:='-   '+s+'   p';
     for i:=1 to length(s) do if s[i]<>' ' then begin
       if s[i]='w' then
        bmp2(tupian+'\'+han+'\w.dib',367-7*(length(s)-i)+136,100,15,4)
       else
        bmp2(tupian+'\'+shu+'\'+s[i]+'.bmp',367-7*(length(s)-i)+136
            +ord((s[i] in ['0'..'9']) and (huirgangnum>0) and (huirgangnum<10))*4,100,
            8+7*ord( (s[i] in ['0'..'9','d']) or
                     ((s[i]='-') and (huirgangnum>0)) or
                     ((s[i]='p') and (huirgangnum<16)) ) ,4);
     end;
   end;
   procedure cleardihubeishu;
   begin
     if nogradeb then exit;
     setfillstyle(1,2);
     bar(325+136,220,360+136,234);
   end;
   procedure printdihubeishu;
     function IntToStr(I: Longint): String;
       var S: string[11];
     begin Str(I, S); IntToStr := S; end;
     var
       s:string;
       i:byte;
   begin
     s:=inttostr(dihubeishu);
     if s='0' then s:='w';s:=s+' ';s:='-   '+s+'   p';
     for i:=1 to length(s) do if s[i]<>' ' then begin
       if s[i]='w' then
        bmp2(tupian+'\'+han+'\w.dib',367-7*(length(s)-i)+136,220,15,4)
       else
        bmp2(tupian+'\'+shu+'\'+s[i]+'.bmp',367-7*(length(s)-i)+136
            +ord((s[i] in ['0'..'9']) and (dihubeishu>0) and (dihubeishu<10))*4,220,
            8+7*ord( (s[i] in ['0'..'9','d']) or
                     ((s[i]='-') and (dihubeishu>0)) or
                     ((s[i]='p') and (dihubeishu<8)) ) ,4);
     end;
   end;
   procedure printdaxiaobeishu;
   begin
     bmp2(tupian+'\'+han+'\-.bmp',210-120   ,220,8+7*ord(daxiaobeishu=0),4);
     bmp2(tupian+'\'+han+'\o.bmp',225-120   ,220,8+7*ord(daxiaobeishu=0),4);
     bmp2(tupian+'\'+han+'\-.bmp',210+136   ,220,8+7*ord(daxiaobeishu=0),4);
     bmp2(tupian+'\'+han+'\o.bmp',225+136   ,220,8+7*ord(daxiaobeishu=0),4);
     bmp2(tupian+'\'+han+'\c.dib',202-120+48,220,8+7*ord(daxiaobeishu=1),4);
     bmp2(tupian+'\'+han+'\j.dib',225-120+48,220,8+7*ord(daxiaobeishu=2),4);
     bmp2(tupian+'\'+han+'\c.dib',202+136+48,220,8+7*ord(daxiaobeishu=1),4);
     bmp2(tupian+'\'+han+'\j.dib',225+136+48,220,8+7*ord(daxiaobeishu=2),4);
   end;
   procedure cleardaxiaobeishu;
   begin
     if nogradeb then exit;
     setfillstyle(1,2);
     bar(210-120,220,225-120+48+15,220+15);
     bar(210+136,220,225+136+48+15,220+15);
   end;
   procedure cleartianhubeishu;
   begin
     if nogradeb then exit;
     setfillstyle(1,2);
     bar(325-120,220,360-120,234);
   end;
   procedure printtianhubeishu;
     function IntToStr(I: Longint): String;
       var S: string[11];
     begin Str(I, S); IntToStr := S; end;
     var
       s:string;
       i:byte;
   begin
     s:=inttostr(tianhubeishu);
     if s='0' then s:='w';s:=s+' ';s:='-   '+s+'   p';
     for i:=1 to length(s) do if s[i]<>' ' then begin
       if s[i]='w' then
        bmp2(tupian+'\'+han+'\w.dib',367-7*(length(s)-i)-120,220,15,4)
       else
        bmp2(tupian+'\'+shu+'\'+s[i]+'.bmp',367-7*(length(s)-i)-120
            +ord((s[i] in ['0'..'9']) and (tianhubeishu>0) and (tianhubeishu<10))*4,220,
            8+7*ord( (s[i] in ['0'..'9','d']) or
                     ((s[i]='-') and (tianhubeishu>0)) or
                     ((s[i]='p') and (tianhubeishu<8)) ) ,4);
     end;
   end;


   procedure printxianggong;
   begin
    bmp2(tupian+'\'+han+'\y.bmp',300+136,300,8+ord(not debugger)*7*ord(    xiangg_),4);
    bmp2(tupian+'\'+han+'\w.dib',360+136,300,8+ord(not debugger)*7*ord(not xiangg_),4);
   end;
   procedure printsubenlong;
   begin
    bmp2(tupian+'\'+han+'\y.bmp',300+136,140,8+7*ord(    subenlong),4);
    bmp2(tupian+'\'+han+'\w.dib',360+136,140,8+7*ord(not subenlong),4);
   end;
   procedure printtianhusuibianbai;
   begin
    bmp2(tupian+'\'+han+'\y.bmp',300+136,180,8+7*ord(    tianhusuibianbai),4);
    bmp2(tupian+'\'+han+'\w.dib',360+136,180,8+7*ord(not tianhusuibianbai),4);
   end;
  procedure rulecf;
    var
      event:tevent;
      f:file of byte;
  begin
    if nogradeb then exit;
    locat:=false;printinit; setfillstyle(1,7);bar(5,0,getmaxx-17,15);
    printtabletitle;printhuirgang;printsubenlong;printtianhusuibianbai;
    printdihubeishu;printtianhubeishu;printdaxiaobeishu;
    printhuirnum;printxiaohu;printdelaytime;printzuozhuang;printxianggong;
    repeat
      printdelaytime;
      mouseinput(event,0); if event.what<>1 then continue;
      if event.where.y in [13,14] then begin
        case event.where.x of
           37-15..38-15:numhuir:=1;41-15..42-15:numhuir:=2;45-15..47-15:numhuir:=3
        end;
        printhuirnum;
      end;
{      setcolor(0);outtextxy(0,0,#219#219#219#219#219);{}
{      setcolor(4);outtextxy(0,0,inttostr(event.where.x)+','+inttostr(event.where.y));{}
     if event.where.y in [13,14] then begin
        clearhuirgang;
        case event.where.x of
          38+17,39+17:if huirgangnum<>0  then dec(huirgangnum,2);
          46+17,47+17:if huirgangnum<>16 then inc(huirgangnum,2);
        end;
        printhuirgang;
      end;
      if event.where.y in [18,19] then begin
        case event.where.x of
          8 ..13:qihu:=1;
          16..21:qihu:=2;
          25..31:qihu:=3;
        end;
        printxiaohu;
      end;
      if event.where.y in [18,19] then begin
        case event.where.x of
          37+17..39+17:subenlong:=true;45+17..47+17:subenlong:=false;
        end;
        printsubenlong;
      end;
      if event.where.y in [23,24] then begin
        case event.where.x of
          37+17..39+17:tianhusuibianbai:=true;
          45+17..47+17:tianhusuibianbai:=false;
        end;
        printtianhusuibianbai;
      end;
      if event.where.y in [23,24] then begin
        case event.where.x of
          37-15..39-15:zuozhuang:=true;45-15..47-15:zuozhuang:=false;
        end;
        printzuozhuang;
      end;
      if event.where.y in [28,29] then begin
        if event.where.x in [38+17,39+17,46+17,47+17] then begin
          cleardihubeishu;
          case event.where.x of
            38+17,39+17:if dihubeishu<>2 then dec(dihubeishu,2);
            46+17,47+17:if dihubeishu<>8 then begin
              inc(dihubeishu,2);
              if (dihubeishu>=tianhubeishu) then tianhubeishu:=dihubeishu;
              cleartianhubeishu;printtianhubeishu;
            end;
          end;
          printdihubeishu;
        end;
      end;
      if event.where.y in [28,29] then begin
        cleartianhubeishu;
        case event.where.x of
          38-15,39-15:if tianhubeishu<>2 then begin
            dec(tianhubeishu,2);
            if (tianhubeishu<=dihubeishu) then dihubeishu:=tianhubeishu;
            cleardihubeishu;printdihubeishu;
          end;
          46-15,47-15:if tianhubeishu<>8 then inc(tianhubeishu,2);
        end;
        printtianhubeishu;
      end;
      if event.where.y in [28,29] then
       if event.where.x in [11..21,43..53] then begin
         cleardaxiaobeishu;
         case event.where.x of
           11..15,43..47:daxiaobeishu:=0;
           16..18,48..50:daxiaobeishu:=1;
           19..21,51..53:daxiaobeishu:=2;
         end;
         printdaxiaobeishu;
      end;
      if event.where.y in [38,39] then begin
        cleardelaytime;
        case event.where.x of
          39-15,40-15:if timedelayn<>1-ord(debugger) then
            begin dec(timedelayn); delaytime:=timedelaytab[timedelayn]; end;
          46-15,47-15:if timedelayn<>22 then
            begin inc(timedelayn); delaytime:=timedelaytab[timedelayn]; end;
        end;
        printdelaytime;
      end;
      if event.where.y in [38,39] then if not debugger then begin
        case event.where.x of
          37+17..39+17:xiangg_:=true;45+17..47+17:xiangg_:=false;
        end;
        printxianggong;
      end;
      if (event.where.y in [45,46]) and (event.where.x in [34-4..38-4]) then begin
        numhuir:=2;qihu:=2;
        delaytime:=20;timedelayn:=3;
        zuozhuang:=false;soundp:=true;
        xiangg_:=false;tianhusuibianbai:=false;
        tianhubeishu:=4;dihubeishu:=4;
        subenlong:=false;huirgangnum:=0;
        daxiaobeishu:=0;
        saveset;
        cleardelaytime;clearhuirgang;cleartianhubeishu;
        cleardihubeishu;cleardaxiaobeishu;
        printhuirgang;printsubenlong;printtianhusuibianbai;
        printdihubeishu;printtianhubeishu;printdaxiaobeishu;
        printhuirnum;printxiaohu;printdelaytime;printzuozhuang;
        printxianggong;
     end;
    until (event.where.y in [45,46]) and (event.where.x in [34+4..38+4]);
    locat:=true;
    if debugger then begin cheat:=true; xiangg_:=false; end;
    saveset;
  end;
  procedure ruleinit;
    label 1;
    var
      err:boolean;
      f:file of byte;
  begin
    if exist('mahjong.set') then begin
      err:=false;
      assign(f,'mahjong.set');reset(f);
      if eof(f) then err:=true else read(f,numhuir);
      if eof(f) then err:=true else read(f,qihu);
      if eof(f) then err:=true else read(f,timedelayn);
      if eof(f) then err:=true else read(f,byte(zuozhuang));
      if eof(f) then err:=true else read(f,byte(soundp));
      if eof(f) then err:=true else read(f,byte(cheat));
      if not eof(f) then read(f,byte(xiangg_));
      if not eof(f) then read(f,huirgangnum);
      if not eof(f) then read(f,byte(subenlong));
      if not eof(f) then read(f,byte(tianhusuibianbai));
      if not eof(f) then read(f,tianhubeishu);
      if not eof(f) then read(f,dihubeishu);
      close(f);
      if (not (numhuir in [1..3])) and
         (not (timedelayn in [0..22])) then err:=true;
      if not (qihu in [1..3]) then err:=true;
      if not debugger and (timedelayn=0) then timedelayn:=1;
      if err then goto 1;
      delaytime:=timedelaytab[timedelayn];
      if odd(huirgangnum) or (huirgangnum>16) then goto 1;
      if not (byte(tianhusuibianbai) in [0,1]) then goto 1;
      if odd(tianhubeishu) or (tianhubeishu>8) or (tianhubeishu<2) then goto 1;
      if odd( dihubeishu ) or ( dihubeishu >8) or ( dihubeishu <2) then goto 1;
      if tianhubeishu<dihubeishu then goto 1;
    end else begin
1:    numhuir:=2;qihu:=2;
      delaytime:=20;timedelayn:=3;
      zuozhuang:=false;soundp:=true;
      xiangg_:=false;tianhusuibianbai:=false;
      tianhubeishu:=4;dihubeishu:=4;
      subenlong:=false;huirgangnum:=0;
      saveset;
    end;
  end;
  procedure saveset;
    var f:file of byte;
  begin
    assign(f,'mahjong.set');rewrite(f);
    write(f,numhuir,qihu, timedelayn, byte(zuozhuang),
            byte(soundp), byte(cheat), byte(xiangg_),
            byte(huirgangnum), byte(subenlong), byte(tianhusuibianbai),
            tianhubeishu, dihubeishu);
    close(f);
  end;
end.