program PPL;
  uses Graph,Bmp,Constant,Print,ProcFunc,Maths,Score,Music,CRT;
  var
    a,b:bd;
    n1,n2:Byte;
    n:Real;
    d:Dot;
    FIn:Boolean;
  procedure runppl;
  begin
    Init(a,n1,n2,n);
    b:=a;
    repeat
      Input(n,a,n1,n2);BJ(a,b);
      v(a,b,px+mx*r-r,py+Round(Sqrt(3)*my*(r-1)+r*2.5),n,n2);
      FIn:=Finish(a);
      if not FIn then lu(a,n1,n2);
      pn(n1);pn2(n2);
    until go(a) or FIn;
  end;
begin
  FileInit('music.txt');DPlay;MainInit(a);
  if paramcount>0 then begin
    ons:=true;roundn:=1;
    if exist(paramstr(1)) then begin
      repeat Load(paramstr(1),a);runppl;roundn:=roundn+1; until roundn<>1;
    end else
    if exist(Dir+paramstr(1)+Extension) then begin
      repeat Load(Dir+paramstr(1)+Extension,a);runppl;roundn:=roundn+1 until roundn<>1;
    end
  end else begin
    ons:=false;
    repeat
      Load(Dir+IntToStr(RoundN)+Extension,a);
      runppl;
      RoundN:=RoundN+1;
    until not exist(Dir+IntToStr(RoundN)+Extension);
  end;
  CloseGraph;
  NoSound;
end.