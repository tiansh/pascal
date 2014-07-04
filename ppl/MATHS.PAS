unit maths;
interface
  uses triangle;
  type
    dot=record
          x,y:longint;
        end;
  function dd(d1,d2:dot):real;
implementation
  function dd;
  begin
    dd:=sqrt(sqr(d1.x-d2.x)+sqr(d1.y-d2.y))
  end;
end.