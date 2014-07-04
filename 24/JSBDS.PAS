{计算表达式的过程抄自
 清华大学出版社《PASCAL程序设计习题与选解（新编）》
第十二章 其它问题12.2
}
unit jsbds;
interface
  function jsbdsb(bds:string):boolean;
implementation
  function jsbdsb(bds:string):boolean;
   var
     nextch:char;
     result:real;
     flag:boolean;
   procedure readnextch;
     {}
     begin
       repeat
         if bds=''{此处有改动}
           then nextch:=';'
           else begin{此处有改动}
                   nextch:=bds[1];
                   bds:=copy(bds,2,length(bds)-1)
               end
     until nextch<>''
     end;{readch}
   procedure readnumber(var number:real);
     {}
     var
     scale:real;
   begin
   {}
     number:=0;
     while nextch in ['0'..'9'] do
       begin
         number:=number*10+ord(nextch)-ord('0');
         readnextch;
       end;
     {此处有改动}
   end;
  procedure readexpression(var exprvalue:real);
    {}
    var
      addop:char;
      nexttermval:real;
    procedure readterm (var termvalue:real);
      {}
      var
        mulop:char;
        nextfacval:real;
      procedure readfactor (var factorvalue:real);
        {}
        begin
          if nextch in ['0'..'9']
            then readnumber(factorvalue)
            else if nextch='('
                   then begin
                     readnextch;
                     {}
                     readexpression(factorvalue);
                     if nextch=')'
                       then readnextch;
                   end
            else begin
                   flag:=false;
                   factorvalue:=1
                 end
      end;{readfactor}
    begin{readterm}
      readfactor(termvalue);
      while nextch in ['*','/'] do
        begin
          mulop:=nextch;
          readnextch;
          {}
          readfactor(nextfacval);
          {}
          case mulop of
            '*':termvalue:=termvalue*nextfacval;
            '/':termvalue:=termvalue/nextfacval;
          end
        end
    end;
  begin{readexpression}
    {}
    readterm(exprvalue);
    while nextch in ['+','-'] do
      begin
        addop:=nextch;
        readnextch;
        {}
        readterm(nexttermval);
        {}
        case addop of
          '+':exprvalue:=exprvalue+nexttermval;
          '-':exprvalue:=exprvalue-nexttermval
        end
      end
  end;{readexpression}
begin
  flag:=true;
  readnextch;
  readexpression(result);
  jsbdsb:=(abs(24-result)<1e-5) and (flag);
end;
end.
