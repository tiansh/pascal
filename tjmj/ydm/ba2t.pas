unit ba2t;
interface
  uses types, variable;
  procedure ba2tiao(a:ba; var b:tiao; nu:byte);
implementation
  procedure ba2tiao(a:ba; var b:tiao; nu:byte);
    var
      i:byte;
  begin
    fillchar(b,sizeof(b),0);
    for i:=1 to nu do inc(b[lei(ord(a[i].lb) mod 4),a[i].sz]);
    for i:=1 to nu do if ord(a[i].lb)>3 then b[lei(ord(a[i].lb) mod 4),a[i].sz]:=0;
    b[z,8]:=0;
    yqjyyyygh:=true;
    for i:=1 to numhuir do begin
      if b[huir[i].lb,huir[i].sz]<>1 then
      yqjyyyygh:=false;
      inc(b[z,8],b[huir[i].lb,huir[i].sz]);
      b[huir[i].lb,huir[i].sz]:=0;
    end;
  end;
end.