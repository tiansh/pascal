unit timers;
interface
  uses bmp,constvar,graph,dos;
  type
    timert=object
      time0,time1:real;
      function  left:longint;
      procedure init;
      procedure show;
      procedure change(D:integer);
    end;
  var
    timerpic:array [0..397,0..18] of byte;
    timer:timert;timeleft:real;
  function qtimer:real;
implementation
  function qtimer:real;
    var
      h,m,s,hs:word;
  begin
    gettime(h,m,s,hs);
    qtimer:=h*3600+m*60+s+hs*0.01;
  end;
  procedure timert.init;
    var i,j:word;
  begin
    bmp16(tupian+'\'+shijt+'.bmp',114,44,16);
    for i:=0 to 397 do for j:=0 to 18 do
     timerpic[i,j]:=getpixel(114+i,44+j);
    time0:=qtimer;
    show;
  end;
  function timert.left;
  begin
    left:=timemax-round(time1-time0);
  end;
  procedure timert.show;
    var i,j,n:word;
  begin
    time1:=qtimer;
    timeleft:=round(left/timelen*397);
    for i:=0 to 397 do for j:=0 to 18 do
      if i<timeleft then putpixel(114+i,44+j,timerpic[i,j])
             else putpixel(114+i,44+j,0);
  end;
  procedure timert.change(D:integer);
  begin
    time0:=time0+D;
    show;
  end;
end.