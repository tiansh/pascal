unit score;
interface
  uses constant,graph,print;
  procedure printscore(s:string);
  procedure ls(c:longint);
  procedure printtext(s:string;x,y:word;size,color:byte);
implementation
  procedure printtext;
  begin
    setcolor(color);
    SetTextStyle(TriplexFont, HorizDir, Size);
    OutTextXY(X , Y-7 , s);
  end;
  procedure printscore;
    var
      X, Y, Size:byte;
  begin
    ps;
    x:=px+55;y:=py-20;size:=2;
    printtext(scoren,x+1,y+1,size,8);
    printtext(scoren,x,y,size,4);
    if not ons then begin
      printtext(inttostr(roundn),x+171,y+1,size,8);
      printtext(inttostr(roundn),x+170,y,size,4);
    end else begin
      printtext('-',x+171,y+1,size,8);
      printtext('-',x+170,y,size,4);
    end;
  end;
  procedure ls;
  function jia(n1,n2:string):string;
    var
      n3:string;
      i:byte;
  begin
    n3:='';
{-1-}if length(n1)<length(n2)
       then for i:=1 to length(n2)-length(n1) do insert('0',n1,1)
       else for i:=1 to length(n1)-length(n2) do insert('0',n2,1);
{-2-}for i:=length(n1) downto 1 do insert(chr(ord(n1[i])+ord(n2[i])-48),n3,1);
{-3-}for i:=length(n1) downto 1 do
       if n3[i]>'9' then begin
         if i=1 then insert('1',n3,1)
                else n3[i-1]:=succ(n3[i-1])
       end;
{-4-}for i:=1 to length(n3) do if n3[i]>'9' then n3[i]:=chr(ord(n3[i])-10);
{-5-}jia:=n3;
  end;
    var
      a,b:string;
      i:integer;
  begin
    str(c,b);a:=scoren;
    scoren:=jia(a,b);
    printscore(scoren);
  end;
end.