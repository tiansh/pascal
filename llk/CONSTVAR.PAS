unit constvar;
interface
  uses drivers;
  const
    totalj:byte=5;
    timemax:word=600;
    timelen:word=600;
    mx=16;my=9;mc=20;bw=32;
    {Graph Size: 639*479}
    px=(639-mx*bw) div 2-bw;
    py=(410-my*bw) div 2-bw+69;
    tupian  :string[4]='图片';
    shubiao :string[4]='鼠标';
    xuanze  :string[4]='菜单';
    shijt   :string[6]='时间条';
    shijd   :string[6]='时间到';
    guoguan :string[4]='过关';
    wancheng:string[4]='完成';
    biaomian:string[4]='表面';
    wujie   :string[4]='无解';
  var
    a,c:array [-1..mx+2,-1..my+2] of byte;
    x1,y1,tl,xl:byte;timel:word;sc:longint;
    timeup,signed,pressed:boolean;
    x,y,wx,wy,i,j,k,l,u:byte;
    event:tevent;key:word;
    i2,j2,k2,l2:byte;
implementation
end.