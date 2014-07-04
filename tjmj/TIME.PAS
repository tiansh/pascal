unit time;
interface
  uses dos,crt,prcot,variable;
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
  begin
    while timer<=t0+ds/100 do if timer<t0 then break else
      if keypressed then
        case readkey of
          #27:done;
          #0:case readkey of
            #45,#107:done;
            #60:runexit:=true;
          end;
        end;
  end;
end.

