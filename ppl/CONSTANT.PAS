unit constant;
interface
  const
    px=130{pels};
    py=25{pels};
    r=18{pels};
    mx=8{balls};
    my=11{balls};
    maxcolor=8;
    mindec=+82.81924421854171867696100437385{ø};
    maxdec=-82.81924421854171867696100437385{ø};
    ed=1.1042565895805562490261467249847{ø};
    maxtime=10{s};
    nodecolor=11{#};
    maxq=15;
    extension='.TXT';
    dir='Map\';
    speed=8;
  type
    bd=array [-1..mx+1,0..my+2] of shortint;
  var
    h,h2:byte;scoren:string;roundn:word;
    w:bd;ons:boolean;
implementation
begin
  scoren:='0';
end.
