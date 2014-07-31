unit bmp16b;
interface
    uses graph,filexist,variable,types,constant;
    type
      ppix=^pix;
      pix=record c:byte; n:ppix; end;
      pic=object
        p:ppix; w,h:word;
        path:string;
        constructor pici;
        procedure   load(path_:string);
        procedure   putp(x,y:word;color:byte;stand:byte);
        procedure   disp;
        destructor  picd;
      end;
      plpc=^lpc;
      lpc=record p:pic; n:plpc; end;
    var
      lstpic:plpc;
    procedure BMP16(path:string;x,y:word;vscolor:byte;stand:byte);
implementation

  constructor pic.pici;
  begin
    p:=nil; w:=0; h:=0;
    path:='';
  end;

procedure pic.load(path_:string);
  const
    color16:array [0..15] of byte
      =(0,4,2,6,1,5,3,8,7,12,10,14,9,13,11,15);
  var
    fin:file of byte;
    width,height:word;
    a:array [1..2] of byte;
    n,k,r:byte;
    i,j,l:longint;
    c,f:byte;
    e,s:ppix;
begin
  if not exist(path_) or nogradeb then exit;
  path:=path_;
  assign(fin,path_); reset(fin);
  seek(fin,10); f:=0; for j:=1 to 4 do
   begin read(fin,c);f:=ord(c)*round(exp(ln(256)*(j-1)))+f; end;
  seek(fin,18); width:=0; for j:=1 to 4 do
   begin read(fin,c);width:=ord(c)*round(exp(ln(256)*(j-1)))+width; end;
  height:=0; for j:=1 to 4 do
   begin read(fin,c);height:=ord(c)*round(exp(ln(256)*(j-1)))+height; end;
  w:=width; h:=height;
  reset(fin); r:=0; seek(fin,f);
  i:=1;j:=1;
  while (i<=height) do begin
    read(fin,c); r:=(r+1) mod 4;
    n:=ord(c);
    a[1]:=n div 16; a[2]:=n mod 16;
    for k:=1 to 2 do begin
      new(e); e^.n:=nil; e^.c:=color16[a[k]];
      if p=nil then begin p:=e; s:=p; end
               else begin s^.n:=e; s:=s^.n; end;
      j:=j+1;
      if j>width then break;
    end;
    if j>width then begin
      j:=1; i:=i+1; if r<>0 then for l:=3 downto r do read(fin,c); r:=0;
    end;
  end;
  close(fin);
end;
procedure pic.putp(x,y:word;color:byte;stand:byte);
  var
    i,j:longint;
    q:ppix;
begin
  i:=1; j:=1; q:=p;
  while q<>nil do begin
   if q^.c<>color then
    case stand of
      3:putpixel(x+i-1,y+j-1,q^.c);
      2:putpixel(x+w-j,y+i-1,q^.c);
      1:putpixel(x+h-i,y+w-j,q^.c);
      4:putpixel(x+j-1,y+h-i,q^.c);
    end;
    inc(j);
    if j>w then begin j:=1; inc(i); end;
    q:=q^.n;
  end;
end;
procedure pic.disp;
  var q:ppix;
begin
  q:=p;
  while p<>nil do begin
    p:=p^.n;
    dispose(q);
    q:=p;
  end;
end;
destructor pic.picd; begin pic.disp; end;

function foundplic(path:string):plpc;
  var
    p,l,n:plpc;
begin
  p:=lstpic; l:=p;
  while p<>nil do begin
    if p^.p.path=path then begin
      foundplic:=p;
      break;
    end;
    l:=p; p:=p^.n;
  end;
  if p=nil then begin
    new(n);
    n^.n:=nil;
    n^.p.pici;
    n^.p.load(path);
    foundplic:=n;
    if l=nil then lstpic:=n else l^.n:=n;
  end;
end;

procedure BMP16(path:string;x,y:word;vscolor:byte;stand:byte);
begin
  if nogradeb then exit;
  foundplic(path)^.p.putp(x,y,vscolor,stand);
end;

procedure bmpinit;
  var
    li:lei; i:byte;
begin
  foundplic(tupian+'\'+shubiao+'.bmp');
  for li:=z to t do for i:=1 to 9-2*ord(li=z) do begin
    foundplic(tupian+'\'+wbt[li]+'\'+char(i+48)+'.bmp');
  end;
end;
begin
  lstpic:=nil;
  bmpinit;
end.
