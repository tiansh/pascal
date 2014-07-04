unit music;
interface
  uses crt,dos;
  const
    base=32.625;
    length1=200;
  var played,fad:boolean;
  procedure play(st:string);
  procedure musicinit;
  procedure dplay;
  procedure fileinit(s:string);
  procedure closefile;
  function  timer:real;
  procedure delays(t:real);
  function  Exist(Path:string):Boolean;
implementation
  function Exist(Path:string):Boolean;
    var
      S: PathStr;
  begin
    S := FSearch(Path, GetEnv(''));
    Exist := S <> '';
  end;
  var
    y1:longint;
    t:byte;m:text;musics:string;
    time0:real;
    delleng:real;
    inited:boolean;
  procedure delays(t:real);
    var
      t0:real;
  begin
    t0:=timer;
    while (timer<t0+t/1000) and (timer>=t0) do dplay;
  end;
  function timer:real;
    var h,m,s,d:word;
  begin
    gettime(h,m,s,d);
    timer:=h*3600+m*60+s+d/100;
  end;
  procedure p(octave,note,duration:integer);
  begin
    if note=0 then nosound
     else sound(round(base*exp(ln(2)*(octave+(note-1)/7))));
    delleng:=duration/1000;
  end;
  procedure play(st:string);
    var
      s:string;
      i,j:byte;code:integer;
      y2,y3:longint;
      d:boolean;
    Function leng(s:string):real;
      var
        l:byte;code:integer;
    begin
      if s[length(s)]='.' then
        leng:=leng(copy(s,1,length(s)-1))*1.5
      else begin
        if s<>'' then
          val(copy(s,1,length(s)),l,code)
          else l:=4;leng:=2000/l*120/t;
      end;
    end;
  begin
    for i:=1 to length(st) do if st[i]=' ' then delete(st,i,1);
    i:=1;
    while i<=length(st) do begin
      j:=i;
      if not (st[j]in ['<','>']) then
      while not (UpCase(st[j+1]) in ['A'..'G','P','O','T','<','>'])
            and (j<>length(st)) do inc(j);
      s:=copy(st,i,j-i+1);
      i:=j+1;
      case UpCase(s[1]) of
        'A'..'G':
          begin
            y3:=round(leng(copy(s,2,length(s)-1)));
            y2:=(ord(upcase(s[1]))-ord('B')+6)mod 7+1;
            p(y1,y2,y3);
          end;
        'P':
          begin
            p(0,0,round(leng(copy(s,2,length(s)-1))));
          end;
        'O':
          begin
            val(copy(s,2,length(s)-1),y1,code);
          end;
        'T':
          begin
            val(copy(s,2,length(s)-1),t,code);
          end;
      end;
      if s='>' then y1:=y1+1;
      if s='<' then y1:=y1-1;
    end;
  end;
  procedure musicinit;
  begin
    y1:=5;t:=120;inited:=false;played:=false;
  end;
  procedure fileinit(s:string);
  begin
    if exist(s) then begin
      assign(m,s);reset(m);musics:='';
      time0:=timer;delleng:=-1;dplay;
      inited:=true;fad:=true;
    end;
  end;
  procedure closefile;
  begin
    nosound;close(m);
  end;
  procedure dplay;
    procedure playp;
      var
        i:byte;
        flag:boolean;
    begin
      if (timer-time0>delleng) or (timer<time0) then begin
        nosound;delay(10);
        if musics='' then begin
          if eof(m) then reset(m);
          repeat
            readln(m,musics);
          until musics[1]<>'''';
          for i:=1 to length(musics) do
            if musics[i]=' ' then delete(musics,i,1);
        end;
        repeat
          i:=1;
          while not (UpCase(musics[i+1]) in ['A'..'G','P','O','T'])
                and (i<length(musics))
                and not (musics[i] in ['>','<']) do inc(i);
          play(copy(musics,1,i));
          flag:=Upcase(musics[1]) in ['A'..'G','P','O','T'];
          delete(musics,1,i);
        until flag;
        time0:=timer;
      end;
    end;
  begin
    if inited and played and fad then playp;
  end;
begin
  fad:=false;
  musicinit;
end.
