program llk;
  uses constvar,print,graph,crt,bmp,gramouse,drivers,procfunc,timers;
  label 1,2,3;
begin
  randomize;inigraph;
  graphmouseinit;init;
repeat
  bmp16(tupian+'\'+xuanze+'.bmp',0,0,16);
  init;
  repeat
    initj;pressed:=false;signed:=false;
    timer.init;
    printa;printxts;
    if not finished then while not cl do begin xl:=xl+1; rp; printxts; end;
  repeat
    mouseinput(event,true);
    if timeup then goto 1;
    if signed then begin
      dissign(i2,j2);
      dissign(k2,l2);
      signed:=false;
    end;
    x:=(event.where.x*8-constvar.px) div 32;
    y:=(event.where.y*8-constvar.py) div 32;
    if a[x,y]=0 then x:=$FF;
    if keypressed then begin
      key:=ord(readkey)*$100;
      if key=0 then key:=ord(readkey);
    end else key:=0;
    case key of
      $006B,$002D,$1B00:begin closegraph; halt; end;
      $003C:begin init;timer.init;initj;printa; end;
      $003D:begin if tl<>0 then tis; end;
      $003E:begin if xl<>0 then rp; while not cl do begin xl:=xl+1; rp; end; end;
    end;
  if event.what<>0 then begin
    if (x in [1..mx]) and (y in [1..my]) and (a[x,y]<>0) then begin
      sign(x,y,12);
      if pressed then begin
        if (x1=x) and (y1=y) then begin dissign(x1,y1);dissign(x,y); end else
        if (a[x1,y1]=a[x,y]) then if ky(x1,y1,x,y,true) then begin
          a[x1,y1]:=0;a[x,y]:=0;
          distory(x1,y1);distory(x,y);
          timer.change(3);
          sc:=sc+10;printxts;
        end else begin dissign(x1,y1);dissign(x,y); timer.change(-2); write('');
        end else begin dissign(x1,y1);dissign(x,y); timer.change(-2); write(''); end;
        pressed:=false;
      end else begin
        x1:=x;y1:=y;pressed:=true;
      end;
    end else begin
      if pressed then dissign(x1,y1);
      pressed:=false;
    end;
    case event.where.y of
      0..2:begin
      case event.where.x of
        77..79:begin closegraph; halt; end;
        0..10:begin init;timer.init;initj;printa; end;
        11..21:begin if tl<>0 then tis; end;
        22..32:begin if xl<>0 then rp; while not cl do begin xl:=xl+1; rp; end; end;
      end end;
      3..4:begin
      case event.where.x of
        11..21:begin if tl<>0 then tis; end;
        22..32:begin if xl<>0 then rp; while not cl do begin xl:=xl+1; rp; end; end;
      end;
      end;
    end;
  end;
  if not finished then begin
    if (xl=0) and not cl then goto 3;
    while not cl do begin xl:=xl+1; rp; while not cl do begin xl:=xl+1; rp; printxts; end; end;
  end;
  until finished;
  sc:=sc+round(timeleft);printxts;
  if u=totalj then goto 2;
  xl:=xl+1;tl:=tl+1;printxts;u:=u+1;
  bmp16(tupian+'/'+guoguan+'.bmp',100,100,16);
  mouseinput(event,false);
  cls;
until false;
2:
cls;
bmp16(tupian+'/'+wancheng+'.bmp',100,100,16);
ptext(inttostr(sc),185,100,15,2);
mouseinput(event,false);
cls;
continue;
1:
cls;
bmp16(tupian+'/'+shijd+'.bmp',100,100,16);
ptext(inttostr(sc),195,100,15,2);
mouseinput(event,false);
cls;timeup:=false;
continue;
3:
cls;
bmp16(tupian+'/'+wujie+'.bmp',100,100,16);
ptext(inttostr(sc),160,198,15,2);
mouseinput(event,false);
cls;
continue;
until false;
end.