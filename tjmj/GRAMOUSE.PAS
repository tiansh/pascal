unit gramouse;
interface
  uses graph,drivers,crt,bmp,constant,prcot,variable;
  procedure mouseshow(x,y:byte);
  procedure mousedisshow;
  procedure graphmouseinit;
  procedure mouseinput(var event:tevent);
implementation
  var
    px,py:word;
    p:pointer;
  procedure graphmouseinit;
  begin
    initevents;
    getmem(p,imagesize(0,0,10,17));
  end;
  procedure mouseshow(x,y:byte);
  begin
    if x*8+10<getmaxx then px:=x*8 else px:=getmaxx-10;
    if y*8+17<getmaxy then py:=y*8 else py:=getmaxy-17;
    getimage(px,py,px+10,py+17,p^);
    bmp16(tupian+'\'+shubiao+'.bmp',x*8,y*8,13,4);
  end;
  procedure mousedisshow;
  begin
    putimage(px,py,p^,normalput);
    dispose(p);
  end;
  procedure mouseinput(var event:tevent);
  begin
    repeat getmouseevent(event); until event.what=0;
    mouseshow(mousewhere.x,mousewhere.y);
    repeat
      getmouseevent(event);
      if event.what=4 then begin
        mousedisshow;
        mouseshow(mousewhere.x,mousewhere.y);
      end;
    until (event.what=1) or keypressed;
    if event.what=1 then
      if event.where.y in [0..2] then begin
       if event.where.x in [77..79] then done;
       if event.where.x in [0..10] then runexit:=true;
      end;
    if keypressed then
      case readkey of
        #27:done;
        #0:case readkey of
          #45,#107:done;
          #60:runexit:=true;
        end;
      end;
    MouseDisShow;
    CheckKeyboard;
  end;
end.