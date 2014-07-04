program plant;
  uses constvar,gramouse,bmp,procfunc,print,graph,crt,rand;
begin
  graphini;graphmouseinit;
  repeat gracls; until plantinit;
  rando(b);
  gracls;boom;
  closegraph;
end.