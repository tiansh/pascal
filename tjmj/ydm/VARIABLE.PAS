unit variable;
interface
  uses types,filexist;
  var
    tianhu:boolean; dihu:array [1..4] of boolean;
    numhuir:byte; qihu:byte;
    xiangg_,xiangg:boolean;
    huirgangnum:byte;subenlong:boolean;
    tianhusuibianbai:boolean;
    checkth:boolean;
    yqjyyyygh:boolean;{youqiejinyou yiyangryige huir}
    tianhubeishu,dihubeishu:byte;
    daxiaobeishu:byte;
    zuozhuang:boolean; kggz,zjkg:boolean;
    locat:boolean; last:zhang;
    huir:array [1..3] of zhang;
    a:tao; anum,alast,ahuir:byte;
    al:tiao2; sh:array [1..4] of ba;
    d:byte; lun,dong,nzhuang:byte;
    num,thr:array [1..4] of byte;
    score:array [1..4] of integer;
    hupstr:string; hupnum:byte;
    gangn:byte; throwout:zhang;
    pgl:boolean; gkhl:boolean; runexit:boolean;
    soundp,cheat:boolean;
    delaytime:word; timedelayn:byte; time0:boolean;

    debugcomq,debugger,nogradeb,psx:boolean;
    numzhuang:longint;

    function sx:byte;
    function zhua:byte;
implementation
  function sx:byte; begin sx:=alast-anum; end;
  function zhua:byte; begin zhua:=(dong+lun+2) mod 4+1; end;
begin
  randomize; time0:=false;
  debugger :=exist('DEBUG.TS');
  debugcomq:=exist('COMQ.DEB');
  nogradeb :=exist('NGRA.DEB');
  if nogradeb then begin debugger:=true; debugcomq:=false; end;
end.