unit gramouse;
interface
  uses graph,drivers,crt,bmp,constvar,print,timers;
  procedure mouseshow(x,y:byte);
  procedure mousedisshow;
  procedure graphmouseinit;
  procedure mouseinput(var event:tevent;time:boolean);
implementation
  var
    px,py:word;
    p:pointer;
  procedure graphmouseinit;
  begin
    initevents;
    getmem(p,imagesize(0,0,21,21));
  end;
  procedure mouseshow(x,y:byte);
  begin
    if x*8+21<getmaxx then px:=x*8 else px:=getmaxx-21;
    if y*8+21<getmaxy then py:=y*8 else py:=getmaxy-21;
    getimage(px,py,px+21,py+21,p^);
    bmp16(tupian+'\'+shubiao+'.bmp',x*8,y*8,13);
  end;
  procedure mousedisshow;
  begin
    putimage(px,py,p^,normalput);
    dispose(p);
  end;
  procedure mouseinput(var event:tevent;time:boolean);
{} var x,y:byte; str:string;{}
  begin
    repeat getmouseevent(event); until event.what=0;
    mouseshow(mousewhere.x,mousewhere.y);
    repeat
      getmouseevent(event);
      if time then begin
        timer.time1:=qtimer;
        if timeleft<>round(timer.left/timelen*397) then begin
          mousedisshow;timer.show;mouseshow(mousewhere.x,mousewhere.y);
        end;
        if timeleft<=0 then begin mousedisshow; timeup:=true;exit; end;
      end;
      if event.what=4 then begin
        mousedisshow;
        mouseshow(mousewhere.x,mousewhere.y);
      end;
    until (event.what=1) or keypressed;
    mousedisshow;
  end;
end.