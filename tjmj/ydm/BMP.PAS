unit bmp;
interface
  uses graph,variable;
  procedure inigraph;
implementation
  procedure inigraph;
    var
      grDriver: Integer;
      grMode: Integer;
      ErrCode: Integer;
  begin
    if nogradeb then exit;
    grDriver := Detect;
{$IFDEF Use8514}                          { check for Use8514 $DEFINE }
    GrDriver := IBM8514;
    GrMode := IBM8514Hi;
{$ELSE}
    GrDriver := Detect;                { use autodetection }
{$ENDIF}
    InitGraph(GrDriver, GrMode, '');
    ErrCode := GraphResult;
    if ErrCode <> grOk then begin
      Writeln('Graphics error:', GraphErrorMsg(ErrCode));
      halt(1);
    end;
  end;
end.
