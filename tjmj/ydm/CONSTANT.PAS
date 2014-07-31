unit constant;
interface
  uses
    types;
  const
    {String Constants}
    tupian:string[2]='tp';
    wbt:array [lei] of string[1]=('z','w','b','t');
    han:string[1]='h'; shu:string[1]='s';
    caidan:string[2]='cd';
    guize:string[2]='gz';
    shubiao:string[4]='sb';
    dnxb:array [0..3] of string[1]=('d','n','x','b');
    tishilan:string[3]='tsl';
    xuanze:string[4]='xz';
    cktc:string[8]='cktc';
    edition:string[6]='6.2.0 ';

    {Integer Constants}
    px:word=20;py:word=20;
    width:byte=24;height:byte=33;

    {Table Constant}
    timedelaytab:array [0..22] of word
       =(0,10,15,20,25,30,35,40,45,50,60,70,80,90,
         100,120,140,160,180,200,250,300,400);

    {Other Constants}
    kb:zhang=(lb:z;sz:0);
    cl:zhang=(lb:z;sz:9);
    bm:zhang=(lb:z;sz:8); {Huir As Also}
    ww:zhang=(lb:w;sz:5);
implementation
end.
