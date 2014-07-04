unit print;
interface
  uses check,crt,input,ran;
  procedure run;
implementation
  procedure run;
    var
      f:boolean;
  begin
    f:=ric;if userstr='' then exit;
    gotoxy(2,5);textcolor(10);textbackground(0);
    if f then write('CONGRATULATIONS!') else write('Wrong! Right answer:',solution);
    readkey;
  end;
end.