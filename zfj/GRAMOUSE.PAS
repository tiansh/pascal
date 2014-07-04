unit gramouse;
interface
  uses graph,drivers,crt,bmp,constvar;
  var mousetype:byte;
  procedure mouseshow(x,y:byte;mt:byte);
  procedure mousedisshow;
  procedure graphmouseinit;
  procedure mouseinput(var event:tevent;mt:byte);
implementation
  var
    px,py:word;
    p:pointer;
  procedure graphmouseinit;
  begin
    initevents;
    getmem(p,imagesize(0,0,18,17));
  end;
  procedure mouseshow(x,y:byte;mt:byte);
  begin
    if mt=1 then begin
      if x*8+18<getmaxx then px:=x*8 else px:=getmaxx-18;
      if y*8+17<getmaxy then py:=y*8 else py:=getmaxy-17;
      getimage(px,py,px+18,py+17,p^);
      bmp16(tupian+'\mouse.bmp',x*8,y*8,13);
    end else if mt in [2,3] then begin
      if x*8+18<getmaxx then px:=x*8    else px:=getmaxx-18;
      if y*8-14>0       then py:=y*8-15 else py:=0;
      getimage(px,py,px+18,py+17,p^);
      bmp16(tupian+'\pencil.bmp',x*8,y*8-14,13);
      putpixel(x*8,y*8,mousetype);
    end;
  end;
  procedure mousedisshow;
  begin
    putimage(px,py,p^,normalput);
    dispose(p);
  end;
  procedure mouseinput(var event:tevent;mt:byte);
  begin
    repeat getmouseevent(event); until event.what=0;
    mouseshow(mousewhere.x,mousewhere.y,mt);
    repeat
      getmouseevent(event);
      if event.what=4 then begin
        mousedisshow;
        mouseshow(mousewhere.x,mousewhere.y,mt);
      end;
    until (event.what=1) or keypressed;
    mousedisshow;
  end;
end.