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
    tao=array [1..136] of zhang;
  function same(a,b:zhang):boolean;
implementation
  function same(a,b:zhang):boolean;begin same:=(a.lb=b.lb)and(a.sz=b.sz) end;
end.