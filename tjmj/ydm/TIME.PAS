unit time;
interface
  uses dos,crt,prcot,variable,filexist;
  function timer:real;
  procedure timein;
  procedure timeout(ds:word);
implementation
  var t0:real;
  function timer:real;
    var h,m,s,ds:word;
  begin
    gettime(h,m,s,ds);
    timer:=h*3600+m*60+s+ds/100;
  end;
  procedure timein;
  begin
    t0:=timer;
  end;
  procedure timeout(ds:word);
    var f:text;
  begin
{    assign(f,'time.log');
    if not exist('time.log') then rewrite(f) else append(f);
    writeln(f,timer-t0:0:2);
    close(f);}
    while timer<=t0+ds/100 do if timer<t0 then break else checkkeyboard;
  end;
end.

