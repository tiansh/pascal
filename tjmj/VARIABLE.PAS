unit variable;
interface
  uses types;
  var
    last:zhang;
    huir,huir2:zhang;
    a:tao; anum,alast,ahuir:byte; al:tiao;
    sh:array [1..4] of ba;
    d:byte; lun,dong,nzhuang:byte;
    num,thr:array [1..4] of byte;
    score:array [1..4] of integer;
    hupstr:string; hupnum:byte;
    gangn:byte; throwout:zhang;
    pgl:boolean; gkhl:boolean; runexit:boolean;
    function sx:byte;
    function zhua:byte;
    procedure ggang(var a:zhang);
implementation
  procedure ggang(var a:zhang);
  begin
    a:=variable.a[gangn]; dec(gangn);
    if gangn=ahuir then dec(gangn);
    if gangn<alast then alast:=gangn;
  end;
  function sx:byte; begin sx:=alast-anum; end;
  function zhua:byte; begin zhua:=(dong+lun+2) mod 4+1; end;
begin
  randomize;
end.