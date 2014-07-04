unit constant;
interface
  uses
    types;
  const
    {String Constants}
    tupian:string[4]='图片';
    wbt:array [lei] of string[2]=('字','万','饼','条');
    han:string[2]='汉'; shu:string[2]='数';
    bei:string[2]='背';
    caidan:string[4]='菜单';
    guize:string[4]='规则';
    shubiao:string[4]='鼠标';
    dnxb:array [0..3] of string[1]=('d','n','x','b');
    tishilan:string[6]='提示栏';
    xuanze:string[4]='选择';
    cktc:string[8]='重开退出';

    {Integer Constants}
    px:word=20;py:word=20;
    width:byte=24;height:byte=33;

    {Other Constants}
    kb:zhang=(lb:z;sz:0);
    cl:zhang=(lb:z;sz:9);
    bm:zhang=(lb:z;sz:8);
    ww:zhang=(lb:w;sz:5);
  var
    dl:zhang;
implementation
  var
    num4:byte;
begin
  num4:=4;
  dl.lb:=lei(num4);dl.sz:=9;
end.
