unit PDHP{Panduan Hupai};
interface
  uses types, variable, constant, prcot;
  function hupai(a:tiao):boolean;
  function xz(a:tiao;var mh,hd,zw,l,lb:boolean):byte;
  function mingming{42}(mh,hd,zw,l,bl:boolean):string;
  procedure ba2tiao(a:ba;var b:tiao; nu:byte);
implementation
  function panduanl(a:tl;huir{4}:byte):boolean;
    label 1;
    var
      i:byte;
      c:tl;
      flag:boolean;
  begin
    if huir>7 then begin
      panduanl:=false; exit;
    end;
    flag:=true;
    for i:=1 to 9 do if a[i]<>0 then flag:=false;
    if flag then begin panduanl:=true; exit; end;
    panduanl:=true;
    for i:=1 to 9 do if a[i]<>0 then begin
      if a[i]>=3 then begin c:=a;c[i]:=c[i]-3; if panduanl(c,huir  ) then exit; end;
      if (a[i] =2) and (huir>=1) then begin c:=a;c[i]:=c[i]-2; if panduanl(c,huir-1) then exit; end;
      if i<8 then
       if (a[i]<>0) and (a[i+1]<>0) and (a[i+2]<>0) then begin
        c:=a;dec(c[i]);dec(c[i+1]);dec(c[i+2]); if panduanl(c,huir) then exit;
        continue;
      end;
      if i<8 then
       if (a[i]<>0) and (a[i+2]<>0) and (huir>=1) then begin
        c:=a;dec(c[i]);dec(c[i+2]);if panduanl(c,huir-1) then exit;
      end;
      if i<9 then
       if (a[i]<>0) and (a[i+1]<>0) and (huir>=1) then begin
        c:=a;dec(c[i]);dec(c[i+1]);if panduanl(c,huir-1) then exit;
      end;
      if huir>=2 then begin
        c:=a;dec(c[i]);if panduanl(c,huir-2) then exit;
      end;
    end;
    panduanl:=false;
  end;
  function panduanz(a:tl;huir:byte):boolean;
    var
      i,total:byte;
  begin
    total:=0;
    for i:=1 to 7 do
      total:=total+(3-((a[i]+2) mod 3+1));
    panduanz:=((huir-total)>=0) and ((huir-total) mod 3=0);
  end;
  function panduanf(a:tiao):boolean;
    var
      total,cha,part:byte;
      l:lei;i:byte;
      nz,nw,nb,nt:byte;
    function num(const l:lei):byte;
      var
        i:byte;
        part:byte;
    begin
      part:=0;
      for i:=1 to 9-ord(l=z)*2 do part:=part+a[l,i];
      num:=part;
    end;
  begin
    if same(last,huir) or same(last,huir2) then last:=bm;
    panduanf:=false;
    for nz:=0 to a[z,8] do
     for nw:=0 to a[z,8]-nz do
     for nb:=0 to a[z,8]-nw-nz do
     for nt:=0 to a[z,8]-nb-nw-nz do
     if nz+nw+nb+nt=a[z,8] then
      if (nz+num(z)) mod 3=0 then
      if (nw+num(w)) mod 3=0 then
      if (nb+num(b)) mod 3=0 then
      if (nt+num(t)) mod 3=0 then
      begin
      if panduanl(a[w],nw) and panduanl(a[b],nb) and panduanl(a[t],nt)
        and panduanz(a[z],nz) then panduanf:=true;
    end;
  end;
  function hupai(a:tiao):boolean;
    var
      jl:lei;jn:byte;
      c:tiao;
  begin
    if same(last,huir) or same(last,huir2) then last:=bm;
    hupai:=false;
    for jl:=z to t do
     for jn:=1 to 9-ord(jl=z) do begin
      if a[jl,jn]>=2 then begin
        c:=a;
        c[jl,jn]:=c[jl,jn]-2;
        if panduanf(c) then begin hupai:=true; exit; end;
      end else
        if (jl<>z) or (jn<>8) then
         if (a[jl,jn]=1) and (a[z,8]<>0) then begin
        c:=a;
        c[jl,jn]:=c[jl,jn]-1;c[z,8]:=c[z,8]-1;
        if panduanf(c) then begin hupai:=true; exit; end;
      end;
     end;
  end;
  function panduan(a:tiao;hd,zw,l:boolean;var lb:boolean):boolean;
    var
      i:byte;
      le:lei;
      b,c:tiao;
      flag,sh:boolean;
      hdp:zhang;
  begin
    if not l then lb:=false;
    if same(last,huir) or same(last,huir2) then last:=bm;
    if zw then if not (same(last,ww) or same(last,bm)) then
       begin panduan:=false; exit end;
    if zw and hd and (a[z,8]-ord(same(last,bm))<2) then begin panduan:=false; exit; end;
   c:=a;
   for sh:=((not hd) or (a[z,8]-ord(same(last,bm))=0)) to ((not hd) or (a[z,8]-ord(same(last,bm))>1)) do begin
    a:=c;
    if hd and (not zw) then begin
      dec(a[last.lb,last.sz]);
      if sh then dec(a[z,8],2) else dec(a[z,8],1);
    end;
    if zw then begin
      if hd then begin
        dec(a[last.lb,last.sz]);
        dec(a[z,8],2);sh:=true;
      end else begin
        dec(a[last.lb,last.sz]);
        if a[w,4]<>0 then dec(a[w,4]) else if a[z,8]<>0 then dec(a[z,8]) else flag:=false;
        if a[w,6]<>0 then dec(a[w,6]) else if a[z,8]<>0 then dec(a[z,8]) else flag:=false;
      end;
    end;
    if l then begin
      b:=a;panduan:=false;
      if huir.lb<>z then begin
        lb:=true;
        le:=huir.lb;
        flag:=true;
        for i:=1 to 9 do if not ((not hd) and (zw) and (le=w) and (i in [4..6])) then begin
          if a[le,i]>0 then dec(a[le,i]) else if a[z,8]>0 then dec(a[z,8]) else flag:=false;
        end;
        if flag then if sh then flag:=hupai(a) else flag:=panduanf(a);
        if flag then begin panduan:=true; exit; end;
      end;
      if (huir.lb=z) or not flag then
      for le:=w to t do if le<>huir.lb then begin
        a:=b;flag:=true;lb:=false;
        for i:=1 to 9 do if not ((zw) and (le=w) and (i in [4..6])) then begin
          if a[le,i]>0 then dec(a[le,i]) else if a[z,8]>0 then dec(a[z,8]) else flag:=false;
        end;
        if flag then if sh then flag:=hupai(a) else flag:=panduanf(a);
        if flag then begin panduan:=true; exit; end;
      end;
      a:=b;
    end;
    if not l then begin
      if sh then flag:=hupai(a) else flag:=panduanf(a);
      if flag then begin panduan:=true; exit end;
    end;
   end;
   panduan:=false;
  end;
  function xz(a:tiao;var mh,hd,zw,l,lb:boolean):byte;
    var
      i:byte;
      n,max:byte;
      h,z,o,b:boolean;
  begin
    if same(last,huir) or same(last,huir2) then last:=bm;
    hd:=false;zw:=false;l:=false;lb:=false;mh:=a[lei(0),8]=0;
    if not hupai(a) then begin xz:=0; exit; end else xz:=1;
    max:=1;
    for i:=ord(not mh) to 7 do begin
      h:=odd(i);z:=odd(i div 2);o:=odd(i div 4);n:=0;
      if panduan(a,h,z,o,b) then begin
        n:=((3*ord(z))+4*ord(o)*(1+ord(b)));
        if n=0 then n:=1;
        n:=n*(1+ord(h or mh));
      end;
      if n>max then begin
        max:=n;hd:=h;zw:=z;l:=o;lb:=b;
      end;
    end;
    xz:=max;
  end;
  function mingming{42}(mh,hd,zw,l,bl:boolean):string;
    var
      s:string;
  begin
    s:='';
    if mh then s:=s+'mhe' else if hd then if zw then s:=s+'she' else s:=s+'hei' else s:='';
    if zw then if (s='') or l then s:=s+'zw' else s:=s+'w';
    if l then if bl then if not zw then s:=s+'~hel' else s:=s+'e~hel' else s:=s+'l';
    if s[length(s)] in ['h','w'] then s:=s+'e';
    mingming:=s;
  end;
  procedure ba2tiao(a:ba; var b:tiao; nu:byte);
    var
      i:byte;
  begin
    fillchar(b,sizeof(b),0);
    for i:=1 to nu do inc(b[lei(ord(a[i].lb) mod 4),a[i].sz]);
    for i:=1 to nu do if ord(a[i].lb)>3 then b[lei(ord(a[i].lb) mod 4),a[i].sz]:=0;
    b[z,8]:=b[huir.lb,huir.sz]+b[huir2.lb,huir2.sz];
    b[huir.lb,huir.sz]:=0;b[huir2.lb,huir2.sz]:=0;
  end;
end.