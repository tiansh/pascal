unit scrprint;
interface
uses graph,constant,dos,filexist,crt,variable;
  procedure ScreenPrint(path:string);
  procedure showinf; procedure disshowinf;
  function autoname:string;
implementation
procedure ScreenPrint(path:string);
const
  FileHead:array [1..118] of byte=(
    $42,$4D,$76,$58,$02,$00,$00,$00,$00,$00,$76,$00,$00,$00,$28,$00,
    $00,$00,$80,$02,$00,$00,$E0,$01,$00,$00,$01,$00,$04,$00,$00,$00,
    $00,$00,$00,$58,$02,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,
    $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$80,$00,$00,$80,
    $00,$00,$00,$80,$80,$00,$80,$00,$00,$00,$80,$00,$80,$00,$80,$80,
    $00,$00,$80,$80,$80,$00,$C0,$C0,$C0,$00,$00,$00,$FF,$00,$00,$FF,
    $00,$00,$00,$FF,$FF,$00,$FF,$00,$00,$00,$FF,$00,$FF,$00,$FF,$FF,
    $00,$00,$FF,$FF,$FF,$00);
  colortable:array [0..15] of byte
      =($0,$4,$2,$6,$1,$5,$3,$8,$7,$C,$A,$E,$9,$D,$B,$F);
var
  f:file of byte;
  i,j:word;
  c1,c2:byte;
begin
    if nogradeb then exit;
  setcolor(7);
  assign(f,path);rewrite(f);
  for i:=1 to 118 do write(f,filehead[i]);
  for i:=0 to 479 do begin
    for j:=0 to 639 do begin
      c1:=getpixel(j,getmaxy-i);c1:=colortable[c1];
      c2:=getpixel(j+1,getmaxy-i);c2:=colortable[c2];
      j:=j+1; c1:=c1*16+c2;
      write(f,c1);
    end;
    line(200+i div 2,8,200+i div 2,15);
    if i>450 then if soundp then sound(1044);
  end;
  {Rules}
    write(f,numhuir,qihu, timedelayn, byte(zuozhuang),
            byte(soundp), byte(cheat), byte(xiangg_),
            byte(huirgangnum), byte(subenlong), byte(tianhusuibianbai),
            tianhubeishu, dihubeishu);
  {Rules}
  close(f);
  nosound;
end;
  procedure disshowinf;
  begin
    if nogradeb then exit;
    setfillstyle(1,7);bar(194,0,getmaxx-17,15);
    setfillstyle(1,2);bar(5,16,37,35);
  end;
  procedure showinf;
  const
    tiansh:array [1..76] of byte=
    ($FF,$FF,$7F,$FF, $FF,$FF,$FF,$FE, $FF,$00,$FF,$FE, $1E,$7F,$FF,$FE,
     $E1,$7F,$FB,$FE, $F5,$7E,$E7,$FE, $FD,$7D,$F7,$C2, $FD,$7D,$77,$FC,
     $FD,$7D,$87,$FE, $FD,$61,$FB,$FE, $7B,$5C,$FB,$FE, $93,$7D,$FD,$F0,
     $EB,$7D,$1F,$FE, $FB,$7D,$FF,$FE, $F7,$BD,$FF,$FE, $F7,$BD,$FF,$FE,
     $77,$B0,$1E,$80, $87,$A7,$E1,$1F, $F7,$DF,$FB,$FF);
    bool:array [0..7] of byte
     =(1,2,4,8,16,32,64,128);
    var
      y,m,d,h,i,s,ds,w:word;
      a,b,xp,yp:byte;
    function s1(a:word):string;
    begin s1[0]:=#1; s1[1]:=chr(48+a); end;
    function s2(a:word):string;
    begin s2[0]:=#2; s2[1]:=chr(48+a div 10); s2[2]:=chr(48+a mod 10); end;
    function s4(a:word):string;
    begin s4[0]:=#4; s4[1]:=chr(48+a div 1000); s4[2]:=chr(48+a div 100 mod 10);
          s4[3]:=chr(48+a div 10 mod 10); s4[4]:=chr(48+a mod 10); end;
  begin
    if nogradeb then exit;
    moveto(200,0);setcolor(4);
    outtext(edition+' ');
    getdate(y,m,d,w);gettime(h,i,s,ds);
    outtext(s4(y)+'-'+s2(m)+'-'+s2(d)+'('+s1(w)+') ');
    outtext(s2(h)+':'+s2(i)+':'+s2(s)+'.'+s2(ds));
    setfillstyle(1,4);bar(200,8,420,15);
    moveto(240,8);setcolor(15);outtext('Printing Screen...');
    xp:=5;yp:=16;
    for a:=1 to 76 do begin
      if a mod 4=1 then begin yp:=yp+1; xp:=5; end;
      for b:=0 to 7 do if (bool[b] and byte(tiansh[a]))=0 then begin
        xp:=xp+1;putpixel(xp,yp,0);
      end else xp:=xp+1;
    end;
  end;
  function autoname:string;
    function IntToStr(I: Longint): String;
    { Convert any integer type to a string }
    var
     S: string[11];
    begin
     Str(I, S);
     IntToStr := S;
    end;
    var i:word;
  begin
    if nogradeb then exit;
    i:=1;while exist(inttostr(i)+'.bmp') and (i<=100) do i:=i+1;
    if exist(inttostr(i)) then i:=1;
    autoname:=inttostr(i);
  end;
end.