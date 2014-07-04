program mahjong{Tianjin Man-jongg};
  uses
    Graph, CRT, Constant, Variable, Types, ProcFunc , Print, BMP, PDHP,
    GraMouse, Drivers, PrCoT; {Comq, ComqPF}
  var
    event:tevent;
begin
  init;
  repeat
    minit;
    repeat
      initj;
      run;
    until (nzhuang>4*4) or runexit;
    if not runexit then checkexit;
  until not runexit;
  done;
end.