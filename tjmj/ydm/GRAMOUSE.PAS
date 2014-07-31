unit gramouse;
interface
  uses graph,drivers,crt,bmp, bmp2b, bmp16b,constant,prcot,variable,print,types,
       scrprint,time,filexist;
  procedure mouseshow;
  procedure mousedisshow;
  procedure graphmouseinit;
  procedure mouseinput(var event:tevent;m:byte);
implementation
  uses ruleset;
  var
    px,py:word;
    p:pointer;
    showmouse:boolean;
  procedure graphmouseinit;
  begin
    if nogradeb then exit;
    getmem(p,imagesize(0,0,32,32));
  end;
  procedure mouseshow;
  begin
    initevents;
    if not showmouse then exit;
    with mousewhere do begin
     if x*8+32<getmaxx then px:=x*8 else px:=getmaxx-32;
     if y*8+32<getmaxy then py:=y*8 else py:=getmaxy-32;
     getimage(px,py,px+32,py+32,p^);
     bmp16(tupian+'\'+shubiao+'.bmp',x*8,y*8,13,4);
    end;
  end;
  procedure mousedisshow;
  begin
    doneevents;
    if not showmouse then exit;
    putimage(px,py,p^,normalput);
    dispose(p);
  end;
  procedure mouseinput(var event:tevent;m:byte);
    {m: 0       - menu
        1       - play
        2,3,4,5 - win
        6       - huangp
    }
    label 1;
    procedure print2bmp;
    begin
      mousedisshow;
      showinf;screenprint(autoname+'.bmp');disshowinf;
      mouseshow;
    end;
    var
      i,j,n:byte;
  begin
    if nogradeb then exit;
    repeat getmouseevent(event); until event.what=0;
    mouseshow;
1:  repeat
      getmouseevent(event);
      if (event.what=4) then begin
        mousedisshow;
        mouseshow;
      end;
    until (event.what=1) or keypressed or (debugger and (m<>0));
    if (event.what=1) then
      if event.where.y in [0..2] then begin
       if event.where.x in [77..79] then done;
       if event.where.x in [1..10] then if locat then runexit:=true;
       if event.where.x in [11..19] then if m<>0 then begin print2bmp; goto 1; end;
      end;
    if keypressed then event.where.y:=90;
    if keypressed then
      case readkey of
        #27:done;
        #0:case readkey of
          #45,#107:done;
          #60:runexit:=true;
          #68:begin print2bmp; goto 1; end;
        end;
        #19:begin
          soundp:=not soundp;
          saveset;
          goto 1;
        end;
        #8:if m<>0 then begin
          mousedisshow;

          cheat:=not cheat;
          for j:=1 to 3 do if j+1<>m then begin
            clearb(j);
            for i:=1 to 14 do if (i<>num[j]) or (j=4) then
              printb(sh[j,i],j,ord(i<=num[j])*i+ord(i=num[j])+ord(i>num[j])*
               (2.4+num[j]+0.75*(i-num[j])+0.4*((i-num[j]-1)div 3)),(j=4)or(i>num[j]));
          end;
          saveset;
          mouseshow;
          goto 1;
        end;
      end;
    MouseDisShow;
  end;
begin
  showmouse:=paramcount=0;
end.