unit procfunc;
interface
  uses print,constvar,gramouse,drivers,bmp,crt,graph,chose;
  function plantinit:boolean;
  procedure boom;
implementation
  function plantinit;
    var
      t:tevent;
      mx,my:byte;
      ptype:byte;
      plantn:tplant;
      num:byte;
  begin
    ptype:=1;num:=1;fillchar(a,sizeof(a),0);
    printbd(px,py);
    printt('Now set your plants...',1,px,qy+10);
    printt('Choose plant types & plants'' places:',14,px,qy+20);
    bmp16(tupian+'\plants.bmp',px,qy+30,0);
    printt('RESET',2,px+50,qy+30+100);
    printt('OK',4,px+100,qy+30+100);
    bmp16(tupian+'\exit.bmp',getmaxx-16,0,16);
    repeat
      mouseinput(t,1);
      if (t.where.x in [6..15]) and (t.where.y in [35..45]) then
      case t.where.x of
        6 ..10:case t.where.y of
          35..39:ptype:=1;
          40..45:ptype:=3;
        end;
        11..15:case t.where.y of
          35..39:ptype:=2;
          40..45:ptype:=4;
        end;
      end;
      case t.where.x of
        12..17:case t.where.y of
          47..48:begin plantinit:=false; exit; end;
        end;
        18..20:case t.where.y of
          47..48:if num>3 then begin plantinit:=true; exit; end;
        end;
      end;
      if (t.where.y*8-py+bw) div bw in [1..9] then begin
        my:=(t.where.y*8-py) div bw+1;
        if (t.where.x*8-px+bw) div bw in [1..9] then
        begin
          mx:=(t.where.x*8-px) div bw+1;

          with plantn do begin
            x:=mx;y:=my;w:=ptype;
          end;
          if num<=3 then begin
            if plantn.check(a) then begin
              plantn.draw;
              num:=num+1;
            end;
          end;

        end;
      end;
      if keypressed then if readkey=#27 then begin closegraph; halt; end;
      if t.where.x>77 then if t.where.y<2 then begin closegraph; halt; end;
    until false;
  end;
  procedure boom;
    label
      1;
    const
      wx=qx+50;
    var
      i,j:byte;
      t:tevent;
      know:bd;
      mx,my:byte;
      l:array [1..9,1..9] of boolean;
    const
      mt:array [1..2,1..8] of byte
        =((16,12,14,10,11, 9,13, 7),
          ( 0, 4, 6, 2, 3, 1, 5, 8));
    procedure comchoose;
      var
        i,j,x,y:byte;
        max:real;
    begin
      choose(know,x,y);
      setcolor(5);rectangle(px+(x-1)*bw+2,py+(y-1)*bw+2,px+x*bw-2,py+y*bw-2);
      know[x,y]:=a[x,y];list[x,y]:=false;
      if a[x,y]=2 then leftp:=leftp-1;
    end;
  begin
    leftp:=3;leftc:=3;mousetype:=16;
    fillchar(list,sizeof(list),true);
    fillchar(l   ,sizeof(l   ),true);
    fillchar(know,sizeof(know),3);
    list[1,1]:=false;list[1,9]:=false;list[9,1]:=false;list[9,9]:=false;
    printbd(wx,py);
    printbd(px,py);
    printbd(wx,py);
    printa;
    bmp16(tupian+'\marks.bmp',px,qy+40,16);
    bmp16(tupian+'\exit.bmp',getmaxx-16,0,16);
    printt('Now attract start. Choose with your mouse.',14,px,qy+20);
    printt('You can make marks:',15,px,qy+30);
    printt('This is yours.',15,px,py-30);
    printt('Press mouse buttons here!',15,wx,py-30);
    if random(3)=0 then comchoose;
    repeat
      1:mouseinput(t,1+ord(mousetype<>16)+ord(mousetype=0));
      if (t.where.y*8-py+bw) div bw in [1..9] then begin
        my:=(t.where.y*8-py) div bw+1;
        if (t.where.x*8-wx+bw) div bw in [1..9] then begin
          mx:=(t.where.x*8-wx) div bw+1;
         if mousetype=16 then begin
          if not l[mx,my] then goto 1;
          l[mx,my]:=false;
          setcolor(b[mx,my]*2);
          circle(wx+(mx-1)*bw+bw div 2,py+(my-1)*bw+bw div 2,bw div 2-4);
          if b[mx,my]=0 then begin
            setcolor(3);
            line(wx+(mx-1)*bw+4,py+(my-1)*bw+4,wx+mx*bw-4,py+my*bw-4);
            line(wx+mx*bw-4,py+(my-1)*bw+4,wx+(mx-1)*bw+4,py+my*bw-4);
          end;
          if b[mx,my]=2 then leftc:=leftc-1;
          if leftc<>0 then comchoose;
         end else begin
          setcolor(mousetype*ord(t.buttons=1));
          rectangle(wx+(mx-1)*bw+2,py+(my-1)*bw+2,wx+mx*bw-2,py+my*bw-2);
         end;
        end;
      end;
      if (t.where.y*8-(qy+40)+20) div 20 in [1..2] then begin
        my:=(t.where.y*8-(qy+40)+20) div 20;
        if (t.where.x*8-px+20) div 20 in [1..8] then begin
          mx:=(t.where.x*8-px+20) div 20;
          mousetype:=mt[my,mx];
        end;
      end;
      if keypressed then if readkey=#27 then begin closegraph; halt; end;
      if t.where.x>77 then if t.where.y<2 then begin closegraph; halt; end;
      if leftc=0 then printt('You win!',6,220,0);
      if leftp=0 then begin
        printt('You lose!',6,220,0);
      end;
      if leftc*leftp=0 then begin
        mouseinput(t,1);
        if t.where.x>77 then if t.where.y<2 then begin closegraph; halt; end;
        for i:=1 to 9 do for j:=1 to 9 do begin
          setcolor(5*ord(not l[i,j]));
          rectangle(px+(i-1)*bw+2,py+(j-1)*bw+2,px+i*bw-2,py+j*bw-2);
        end;
        a:=b;printa;
        mouseinput(t,1);
        exit;
      end;
    until false;
  end;
end.
