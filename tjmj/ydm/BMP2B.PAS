unit bmp2b;
interface
    uses graph,filexist,variable,types,constant;
    type
      ppix=^pix;
      pix=record c:boolean; n:ppix; end;
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
    procedure BMP2(path:string;x,y:word;color,stand:byte);
implementation

  constructor pic.pici;
  begin
    p:=nil; w:=0; h:=0;
    path:='';
  end;

procedure pic.load(path_:string);
  var
    fin:file of byte;
    width,height:word;
    a:array [1..8] of boolean;
    n,k:byte;
    i,j,l:longint;
    c,f:byte;
    e,s:ppix;
begin
  if not exist(path_) then exit;
  path:=path_;
  assign(fin,path_); reset(fin);
  seek(fin,10); f:=0; for j:=1 to 4 do
   begin read(fin,c);f:=ord(c)*round(exp(ln(256)*(j-1)))+f; end;
  seek(fin,18); width:=0; for j:=1 to 4 do
   begin read(fin,c);width:=ord(c)*round(exp(ln(256)*(j-1)))+width; end;
  height:=0; for j:=1 to 4 do
   begin read(fin,c);height:=ord(c)*round(exp(ln(256)*(j-1)))+height; end;
  w:=width; h:=height;
  reset(fin);  seek(fin,f);
  i:=1;j:=1;
  while (i<=height) do begin
    read(fin,c);
    n:=ord(c);
    for k:=1 to 8 do begin
      a[9-k]:=odd(n);
      n:=n div 2;
    end;
    for k:=1 to 8 do begin
      new(e); e^.n:=nil; e^.c:=a[k];
      if p=nil then begin p:=e; s:=p; end
               else begin s^.n:=e; s:=s^.n; end;
      j:=j+1;
      if j>width then break;
    end;
    if j>width then begin
      j:=1; i:=i+1;
      for l:=1 to 3-(((width+7)div 8+3)mod 4) do read(fin,c);
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
   if not q^.c then
    case stand of
      1:putpixel(x+i-1,y+j-1,color);
      2:putpixel(x+w-j,y+i-1,color);
      3:putpixel(x+h-i,y+w-j,color);
      4:putpixel(x+j-1,y+h-i,color);
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

procedure BMP2(path:string;x,y:word;color,stand:byte);
begin
  if nogradeb then exit;
  foundplic(path)^.p.putp(x,y,color,stand);
end;
procedure bmpinit;
  var
    c:char;
begin
  for c:='0' to '9' do
    foundplic(tupian+'\'+shu+'\'+c+'.bmp');
  foundplic(tupian+'\'+han+'\d.bmp');
  foundplic(tupian+'\'+han+'\n.bmp');
  foundplic(tupian+'\'+han+'\x.bmp');
  foundplic(tupian+'\'+han+'\b.bmp');
  foundplic(tupian+'\'+han+'\e.bmp');
  foundplic(tupian+'\'+han+'\p.bmp');
  foundplic(tupian+'\'+han+'\g.bmp');
  foundplic(tupian+'\'+han+'\u.bmp');
  foundplic(tupian+'\'+han+'\h.bmp');
end;
begin
  lstpic:=nil;
  bmpinit;
end.
