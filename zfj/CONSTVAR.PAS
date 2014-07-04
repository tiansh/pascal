unit constvar;
interface
  uses graph;
  const
    pw:array [1..4] of record
      map:array [1..5,1..5] of boolean;
      head:record x,y:byte; end;
    end
    =(
      (map:(
      (FALSE,FALSE,TRUE ,FALSE,FALSE),
      (TRUE ,TRUE ,TRUE ,TRUE ,TRUE ),
      (FALSE,FALSE,TRUE ,FALSE,FALSE),
      (FALSE,TRUE ,TRUE ,TRUE ,FALSE),
      (FALSE,FALSE,FALSE,FALSE,FALSE));
      head:(x:3;y:1)),

      (map:(
      (FALSE,FALSE,FALSE,TRUE ,FALSE),
      (FALSE,TRUE ,FALSE,TRUE ,FALSE),
      (FALSE,TRUE ,TRUE ,TRUE ,TRUE ),
      (FALSE,TRUE ,FALSE,TRUE ,FALSE),
      (FALSE,FALSE,FALSE,TRUE ,FALSE));
      head:(x:5;y:3)),

      (map:(
      (FALSE,FALSE,FALSE,FALSE,FALSE),
      (FALSE,TRUE ,TRUE ,TRUE ,FALSE),
      (FALSE,FALSE,TRUE ,FALSE,FALSE),
      (TRUE ,TRUE ,TRUE ,TRUE ,TRUE ),
      (FALSE,FALSE,TRUE ,FALSE,FALSE));
      head:(x:3;y:5)),

      (map:(
      (FALSE,TRUE ,FALSE,FALSE,FALSE),
      (FALSE,TRUE ,FALSE,TRUE ,FALSE),
      (TRUE ,TRUE ,TRUE ,TRUE ,FALSE),
      (FALSE,TRUE ,FALSE,TRUE ,FALSE),
      (FALSE,TRUE ,FALSE,FALSE,FALSE));
      head:(x:1;y:3))


    );
    
    tupian :string[4]='ͼƬ';

    px=45;py=30;
    bw=24;
    qx=px+bw*9;
    qy=py+bw*9;

  type
    bd=array[1..9,1..9] of byte;
    {0 as Nothing, 1 as Boom, 2 as Crash!}
    tplant=object
      x,y,w:byte;
      procedure draw;
      function  check(a:bd):boolean;
    end;
  var
    a,b:bd;
    list:array [1..9,1..9] of boolean;
    leftc,leftp:byte;
implementation
  procedure tplant.draw;
    var
      i,j:byte;
  begin
    for i:=1 to 5 do for j:=1 to 5 do begin
      if pw[w].map[j,i] then begin
        setcolor(2);a[(x+i-pw[w].head.x),(y+j-pw[w].head.y)]:=1;
        if (j=pw[w].head.y) and (i=pw[w].head.x) then begin
          setcolor(4);a[(x+i-pw[w].head.x),(y+j-pw[w].head.y)]:=2;
        end;
        circle(px+(x+i-1-pw[w].head.x)*bw+bw div 2,py+(y+j-1-pw[w].head.y)*bw+bw div 2,bw div 2-4);
      end;
    end;
  end;
  function tplant.check;
    var
      i,j:byte;
      flag:boolean;
  begin
    flag:=true;
    for i:=1 to 5 do for j:=1 to 5 do if pw[w].map[j,i] then begin
      if not ((x+i-pw[w].head.x) in [1..9]) or
         not ((y+j-pw[w].head.y) in [1..9]) then
         flag:=false
      else if a[(x+i-pw[w].head.x),(y+j-pw[w].head.y)]<>0 then begin
         flag:=false;
      end;
    end;
    check:=flag;
  end;
end.
