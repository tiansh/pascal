program Mahjong;
  uses
    Graph, CRT, Constant, Variable, Types,
    ProcFunc, Print, BMP, BMP2B, BMP16B, PDHP,
    GraMouse, Drivers, PrCoT, RuleSet;
    {Comq, ComqPF, HPXS, Ba2T, Time, ScrPrint}
begin
  init;
  repeat minit; rulecf;
    repeat initj;
      run;
      if debugger then nzhuang:=0;
    until (nzhuang>4*4) or runexit;
    if not runexit then checkexit;
  until not runexit;
  done;
end.