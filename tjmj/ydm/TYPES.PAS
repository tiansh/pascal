unit types;
interface
  type
    lei{4}=(z{i4},w{an4},b{ing3},t{iao2});
    zhang{1}=record
      lb{lei4bie2}:lei;
      sz{shu4zi4}:byte;
    end;
    ba{3}=array [1..14] of zhang;
    tl=array [1..9] of byte;
    tiao{2}=array [lei] of tl;
    tl2=array [1..9] of shortint;
    tiao2=array [lei] of tl2;
    tao=array [1..136] of zhang;
    numlt=array [1..9] of byte;
    iult=array [1..9] of real;
    bbt=array [lei] of numlt;
    iut=array [lei] of iult;
  function same(a,b:zhang):boolean;
  function samehuir(a:zhang):boolean;
implementation
  uses variable;
  function same(a,b:zhang):boolean;
  begin
    same:=(a.lb=b.lb)and(a.sz=b.sz)
  end;
  function samehuir(a:zhang):boolean;
    var i:byte;
  begin
    samehuir:=false;
    if a.lb=huir[1].lb then
     for i:=1 to numhuir do
     if a.sz=huir[i].sz then samehuir:=true;
  end;
end.
