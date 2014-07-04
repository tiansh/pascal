unit triangle;
interface
  function RedToDec (x:real):real;
  function DecToRed (x:real):real;
  function DecSin   (x:real):real;
  function DecCos   (x:real):real;
  function DecTan   (x:real):real;
  function DecCot   (x:real):real;
  function ArcSin   (x:real):real;
  function ArcCos   (x:real):real;
  function ArcCot   (x:real):real;
  function DecASin(x:real):real;
  function DecACos(x:real):real;
  function DecATan(x:real):real;
  function DecACot(x:real):real;
implementation
  function redtodec;
  begin
    redtodec:=x/pi*180
  end;
  function dectored;
  begin
    dectored:=x/180*pi
  end;
  function decsin;
  begin
    decsin:=sin(dectored(x))
  end;
  function deccos;
  begin
    deccos:=cos(dectored(x))
  end;
  function dectan;
  begin
    dectan:=decsin(x)/deccos(x)
  end;
  function deccot;
  begin
    deccot:=deccos(x)/decsin(x)
  end;
  function arcsin;
  begin
   arcsin:=ArcTan(x/sqrt(1-sqr(x)));
  end;
  function arccos;
  begin
    ArcCos:=ArcTan(sqrt(1-sqr(x))/x)
  end;
  function arccot;
  begin
    arccot:=arctan(1/x)
  end;
  function decasin;
  begin
    decasin:=redtodec(ArcSin(x));
  end;
  function decacos;
  begin
    DecACos:=redtodec(arccos(x));
  end;
  function decatan;
  begin
    decatan:=redtodec(arctan(x))
  end;
  function decacot;
  begin
    decacot:=redtodec(arccot(x))
  end;
end.
