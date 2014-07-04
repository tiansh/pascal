unit chose;
interface
  uses
    constvar,graph,crt;
procedure choose(know:bd;var x,y:byte);
implementation
procedure choose;
  var
    a,b,c,d,e,f,g,h,i,j,k,o:byte;
    p,q,r,s:bd;
    num:longint;m:array [0..2] of byte;
    l:tplant;
    sc:array [1..9,1..9,0..2] of word;
    scn:array [1..9,1..9] of real;
    flag:boolean;
    min:real;
begin
  fillchar(p,sizeof(p),0); fillchar(sc,sizeof(sc),0);
  num:=0;
  for a:=1 to 9 do for b:=1 to 9 do for c:=1 to 4 do begin
    q:=p;with l do begin l.x:=a;l.y:=b;l.w:=c end;
    if l.check(q) then begin
      for j:=1 to 5 do for k:=1 to 5 do begin
       if pw[l.w].map[k,j] then
         q[(l.x+j-pw[l.w].head.x),(l.y+k-pw[l.w].head.y)]:=1;
       if (k=pw[l.w].head.y) and (j=pw[l.w].head.x) then
         q[(l.x+j-pw[l.w].head.x),(l.y+k-pw[l.w].head.y)]:=2;
      end;

  for d:=1 to 9 do for e:=1 to 9 do for f:=1 to 4 do begin
    r:=q;with l do begin l.x:=d;l.y:=e;l.w:=f end;
    if l.check(r) then begin
      for j:=1 to 5 do for k:=1 to 5 do begin
       if pw[l.w].map[k,j] then
         r[(l.x+j-pw[l.w].head.x),(l.y+k-pw[l.w].head.y)]:=1;
       if (k=pw[l.w].head.y) and (j=pw[l.w].head.x) then
         r[(l.x+j-pw[l.w].head.x),(l.y+k-pw[l.w].head.y)]:=2;
      end;

  for g:=1 to 9 do for h:=1 to 9 do for i:=1 to 4 do begin
    s:=r;with l do begin l.x:=g;l.y:=h;l.w:=i end;
    if l.check(s) then begin
      for j:=1 to 5 do for k:=1 to 5 do begin
       if pw[l.w].map[k,j] then
         s[(l.x+j-pw[l.w].head.x),(l.y+k-pw[l.w].head.y)]:=1;
       if (k=pw[l.w].head.y) and (j=pw[l.w].head.x) then
         s[(l.x+j-pw[l.w].head.x),(l.y+k-pw[l.w].head.y)]:=2;
      end;
{<BODY>}
   if keypressed then if readkey=#27 then begin closegraph; halt; end;

   flag:=true;
   for j:=1 to 9 do for k:=1 to 9 do if know[j,k]<>3 then
    if s[j,k]<>know[j,k] then flag:=false;
   if flag then if know[j,k]=3 then for j:=1 to 9 do for k:=1 to 9 do
     inc(sc[j,k,s[j,k]]);

   num:=num+1;
{</BODY>}
    end;
  end;


    end;
  end;

    end;
  end;
  for j:=1 to 3 do m[j]:=0;
  for j:=1 to 9 do for k:=1 to 9 do if list[j,k] then
    for o:=0 to 2 do inc(m[o],ord(sc[j,k,o]<>0));
  for j:=1 to 9 do for k:=1 to 9 do begin
    scn[j,k]:=(sqr(sc[j,k,0]/100)*sqrt(26/77)*(sqrt(m[0])+1)
               +
               sqr(sc[j,k,1]/100)*sqrt(47/77)*(sqrt(m[1])+1)
              )
              /
              (exp(ln(leftp)*0.9))
              /
              exp(ln(num/1000)*0.5)
              -(sqr(sc[j,k,2])
                *
                sqrt(20/77))
                *
                (sqrt(m[2])+1);
    if list[j,k] then begin scn[j,k]:=scn[j,k]+random; min:=scn[j,k];x:=j;y:=k; end;
  end;
  for j:=1 to 9 do for k:=1 to 9 do begin
    if list[j,k] then if scn[j,k]<min then begin min:=scn[j,k]; x:=j;y:=k; end;
  end;
end;
end.
