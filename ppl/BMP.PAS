unit bmp;
interface
    uses graph,music;
    const
      maxx=19;maxy=9;
    var
      x,y:byte;
    procedure BMP16(path:string;x,y:word;vscolor:byte);
    procedure inigraph;
implementation
  procedure inigraph;
    var
      grDriver: Integer;
      grMode: Integer;
      ErrCode: Integer;
  begin
    grDriver := Detect;
{$IFDEF Use8514}                          { check for Use8514 $DEFINE }
    GrDriver := IBM8514;
    GrMode := IBM8514Hi;
{$ELSE}
    GrDriver := Detect;                { use autodetection }
{$ENDIF}
    InitGraph(GrDriver, GrMode, '');
    ErrCode := GraphResult;
    if ErrCode <> grOk then begin
      Writeln('Graphics error:', GraphErrorMsg(ErrCode));
      halt(1);
    end;
  end;
procedure BMP16(path:string;x,y:word;vscolor:byte);
  const
    color16:array [0..15] of byte
      =(0,4,2,6,1,5,3,8,7,12,10,14,9,13,11,15);
  var
    fin:text;
    width,height,f:word;
    a:array [1..2] of byte;
    n,k,r:byte;
    i,j,l:longint;
    c:char;
begin
  assign(fin,'bmp\'+path);
  reset(fin);
  for i:=1 to 10 do read(fin,c);
  f:=0;
  for j:=1 to 4 do begin
    read(fin,c);f:=ord(c)*round(exp(ln(256)*(j-1)))+f;
  end;
  for i:=1 to 4 do read(fin,c);
  width:=0;
  for j:=1 to 4 do begin
    read(fin,c);width:=ord(c)*round(exp(ln(256)*(j-1)))+width;
  end;
  height:=0;
  for j:=1 to 4 do begin
    read(fin,c);height:=ord(c)*round(exp(ln(256)*(j-1)))+height;
  end;
  reset(fin);r:=0;
  for i:=1 to f do read(fin,c);
  i:=1;j:=1;
  while (i<=height) do begin
    read(fin,c);r:=(r+1) mod 4;
    n:=ord(c);
    a[1]:=n div 16;
    a[2]:=n mod 16;
    for k:=1 to 2 do begin
      if color16[a[k]]<>vscolor then putpixel(x+j-1,y+height-i,color16[a[k]]);
      j:=j+1;if j>width then break;
    end;
    if j>width then begin
      j:=1;
      i:=i+1;
      if r<>0 then for l:=3 downto r do read(fin,c);
      r:=0;
      dplay;
    end;
  end;
  close(fin);
end;
end.
